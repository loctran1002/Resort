USE RESORT
GO

----- Store Procedure/Function ------
-----------  Question 1 -------------
DROP FUNCTION IF EXISTS GoiDichVufunction
GO

CREATE FUNCTION GoiDichVufunction(@maKH CHAR(8))
RETURNS @ketqua TABLE
(
	TenGoi		VARCHAR(100),
	SoKhach		TINYINT,
	NgayBatDau	DATETIME,
	NgayHetHan	DATETIME,
	SoNgaySuDungConLai INT
)	
AS
BEGIN
	DECLARE @ten_goi		VARCHAR(100),
			@so_khach		TINYINT,
			@so_ngay		INT,
			@ngay_bat_dau	DATETIME,
			@ngay_het_han	DATETIME,
			@ngay_gio_mua	DATETIME,
			@han_su_dung	DATETIME;
	SELECT	@ten_goi = TenGoi, @ngay_bat_dau = NgayBatDau, @ngay_gio_mua = NgayGioMua
	FROM HoaDonGoiDichVu WHERE MaKhachHang = @maKH;
	SELECT @so_khach = SoKhach, @so_ngay = SoNgay
	FROM HoaDonGoiDichVu AS HDGDV JOIN GoiDichVu AS GDV ON HDGDV.TenGoi = GDV.TenGoi
	WHERE MaKhachHang = @maKH;
	SET @ngay_het_han = (SELECT DATEADD(day,@so_ngay,@ngay_bat_dau));
	SET @han_su_dung = (SELECT DATEADD(DAY,365,@ngay_gio_mua));
	INSERT @ketqua
    SELECT @ten_goi, @so_khach, @ngay_bat_dau, @ngay_het_han,
		(CASE 
		WHEN GETDATE() >= @han_su_dung OR @ngay_bat_dau >= @han_su_dung THEN 0
		WHEN ((@ngay_bat_dau IS NULL) and (@han_su_dung>=GETDATE())) 
				and DATEDIFF(day, getdate(),@han_su_dung)<@so_ngay THEN DATEDIFF(day, getdate(),@han_su_dung)
		WHEN ((@ngay_bat_dau IS NULL) and (@han_su_dung>=GETDATE())) 
				and DATEDIFF(day, getdate(),@han_su_dung)>=@so_ngay THEN @so_ngay
		WHEN @ngay_het_han > @han_su_dung AND @han_su_dung > GETDATE() AND GETDATE() >= @ngay_bat_dau
			THEN  DATEDIFF(day, GETDATE(), @han_su_dung)
		WHEN @ngay_het_han > @han_su_dung AND @han_su_dung > @ngay_bat_dau AND GETDATE() < @ngay_bat_dau
			THEN  DATEDIFF(day, @ngay_bat_dau, @han_su_dung)
		WHEN GETDATE() >= @ngay_het_han THEN 0
		WHEN GETDATE() < @ngay_het_han AND GETDATE() >= @ngay_bat_dau THEN DATEDIFF(day, getdate(),@ngay_het_han)
		ELSE @so_ngay
		END);
        
     RETURN;
END;
GO

SELECT * FROM GoiDichVufunction('KH111111')
SELECT * FROM GoiDichVufunction('KH222222')


-----------  Question 2 -------------
DROP FUNCTION IF EXISTS ThongKeLuotKhach
GO

CREATE OR ALTER FUNCTION ThongKeLuotKhach (@MaCN VARCHAR(7), @Nam INT)
RETURNS @ThongKe TABLE
(
	"Tháng"	VARCHAR(2)	PRIMARY KEY,
	"Tổng số lượt khách" INT DEFAULT 0
)
AS
BEGIN
	--Set up month--
	DECLARE @month INT;
	SET @month = 1;
	WHILE @month <= 12
	BEGIN
		INSERT INTO @ThongKe ("Tháng", "Tổng số lượt khách")
		VALUES
		(
			RIGHT('0' + CONVERT(VARCHAR, @month),2),
			ISNULL((SELECT SUM(d.SoKhach)
			FROM DonDatPhong d JOIN PhongThue p ON d.MaDatPhong = p.MaDatPhong
			WHERE @MaCN = p.MaChiNhanh AND YEAR(d.NgayTraPhong) = @Nam AND MONTH(d.NgayTraPhong) = @month), 0)
		)
		SET @month = @month + 1;
	END;
	RETURN
END;
GO

SELECT *
FROM ThongKeLuotKhach('CN10', 2021)



----------- Trigger -----------
-------------------------------
--------- Question 1a ---------
DROP TRIGGER IF EXISTS GiamGia
GO

CREATE TRIGGER GiamGia
ON HoaDonGoiDichVu
FOR INSERT
AS
BEGIN
	DECLARE @TenGoi		VARCHAR(100),
			@MaKH		CHAR(8),
			@NgayGioMua	DATETIME,
			@DiemKH		INT;
	SELECT @TenGoi = TenGoi FROM INSERTED
	SELECT @NgayGioMua = NgayGioMua FROM INSERTED
	SELECT @MaKH = MaKhachHang FROM INSERTED
	SET @DiemKH = (SELECT k.Diem FROM KhachHang k WHERE k.MaKhachHang = @MaKH)
	IF (100 <= @DiemKH AND @DiemKH < 1000)
		BEGIN
			UPDATE HoaDonGoiDichVu SET TongTien = TongTien * 85 / 100
			WHERE MaKhachHang = @MaKH AND TenGoi = @TenGoi AND NgayGioMua = @NgayGioMua
		END;
	ELSE IF (@DiemKH >= 1000)
		BEGIN
			UPDATE HoaDonGoiDichVu SET TongTien = TongTien * 80 / 100
			WHERE MaKhachHang = @MaKH AND TenGoi = @TenGoi AND NgayGioMua = @NgayGioMua
		END;
END
GO

INSERT INTO HoaDonGoiDichVu(MaKhachHang, TenGoi, NgayGioMua, NgayBatDau, TongTien)
VAlUES ('KH222222','GOI D', '2021-02-22 08:00:00', NULL, 100000)

INSERT INTO HoaDonGoiDichVu(MaKhachHang, TenGoi, NgayGioMua, NgayBatDau, TongTien)
VAlUES ('KH444444','GOI C', '2021-08-20 08:00:00', '2021-11-20 08:00:00', 50000)


--------- Question 1b ---------
DROP TRIGGER IF EXISTS KhuyenMai
GO

CREATE TRIGGER KhuyenMai
ON DonDatPhong
FOR INSERT, UPDATE
AS
BEGIN
DECLARE		@id		CHAR(16),
			@point	INT,
			@idKH	CHAR(8);
	SELECT @id = MaDatPhong FROM INSERTED
	SELECT @idKH = MaKhachHang FROM INSERTED
	SET @point = (SELECT k.Diem FROM KhachHang k WHERE k.MaKhachHang = @idKH)

	IF (50 <= @point AND @point < 100)
		UPDATE DonDatPhong SET TongTien = TongTien * 90 / 100
		WHERE MaDatPhong = @id
	ELSE IF (100 <= @point AND @point < 1000)
		BEGIN
			UPDATE KhachHang SET SoNgayCongThem = SoNgayCongThem + 1
			WHERE MaKhachHang = @idKH
			UPDATE DonDatPhong SET TongTien = TongTien * 85 / 100
			WHERE MaDatPhong = @id
		END;
	ELSE IF (@point >= 1000)
		BEGIN
			UPDATE KhachHang SET SoNgayCongThem = SoNgayCongThem + 2
			WHERE MaKhachHang = @idKH
			UPDATE DonDatPhong SET TongTien = TongTien * 80 / 100
			WHERE MaDatPhong = @id
		END;
END
GO

INSERT INTO DonDatPhong(NgayGioDat, SoKhach, NgayNhanPhong, NgayTraPhong, TinhTrang, TongTien, MaKhachHang, TenGoiDichVu)
VAlUES ('2021-11-20 20:00:00', 1,'2021-11-25 07:00:00', '2021-11-27 19:00:00', 1, 10000, 'KH222222', 'GOI A')


--------- Question 1c ---------
DROP TRIGGER IF EXISTS DiemKhachHang
GO
 
CREATE TRIGGER DiemKhachHang
ON KhachHang
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaKH       CHAR(8),
            @DiemKH     INT,
            @Total      DECIMAL(10,2);
    SELECT @MaKH = MaKhachHang FROM INSERTED
    SELECT @DiemKH = Diem FROM INSERTED
    SET @Total = (SELECT SUM(h.TongTien) FROM HoaDonGoiDichVu h WHERE h.MaKhachHang = @MaKH)
	UPDATE KhachHang SET Diem = Diem + FLOOR(@Total / 1000)
    WHERE MaKhachHang = @MaKH
	SET @Total = (SELECT SUM(h.TongTien) FROM DonDatPhong h WHERE h.MaKhachHang = @MaKH)
	UPDATE KhachHang SET Diem = Diem + FLOOR(@Total / 1000)
    WHERE MaKhachHang = @MaKH
END
GO

INSERT INTO DonDatPhong(NgayGioDat, SoKhach, NgayNhanPhong, NgayTraPhong, TinhTrang, TongTien, MaKhachHang, TenGoiDichVu)
VAlUES ('2021-11-20 20:00:00', 5,'2021-11-25 07:00:00', '2021-11-27 19:00:00', 1, 100000, 'KH222222', 'GOI D')


--------- Question 1d ---------
DROP TRIGGER IF EXISTS LoaiKhachHang
GO

CREATE TRIGGER LoaiKhachHang
ON KhachHang
AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE KhachHang SET Loai = (CASE
		WHEN i.Diem<50 THEN 1
		WHEN i.Diem>=50 AND i.Diem<100  THEN 2
		WHEN i.Diem>=100 AND i.Diem<1000 THEN 3
		ELSE 4
    END)
    FROM KhachHang k JOIN INSERTED i ON k.MaKhachHang = i.MaKhachHang;
END

UPDATE KhachHang SET Diem = 1100 WHERE MaKhachHang = 'KH333333'


--------- Question 2 ---------
DROP TRIGGER IF EXISTS MuaGoiDichVu
GO

CREATE TRIGGER MuaGoiDichVu
ON HoaDonGoiDichVu
FOR INSERT
AS
BEGIN
	DECLARE @TenGoi		VARCHAR(100),
			@GiaGoi		DECIMAL(10,2),
			@MaKH		CHAR(8),
			@SoNgay		INT,
			@ThoiHan	DATETIME,
			@NgayBatDau	DATETIME,
			@NgayGioMua	DATETIME,
			@HanSuDung	DATETIME;
	SELECT @MaKH = MaKhachHang FROM INSERTED
	SELECT @TenGoi = TenGoi FROM INSERTED
	SELECT @NgayGioMua = NgayGioMua FROM INSERTED
	SELECT @NgayBatDau = NgayBatDau FROM INSERTED

	DELETE FROM HoaDonGoiDichVu	WHERE MaKhachHang = @MaKH AND TenGoi = @TenGoi AND NgayGioMua = @NgayGioMua

	SET @GiaGoi = (SELECT Gia FROM GoiDichVu WHERE TenGoi = @TenGoi);
	SET @SoNgay = (SELECT SoNgay FROM GoiDichVu g WHERE g.TenGoi = @TenGoi);
	IF ((SELECT COUNT(h.NgayBatDau) FROM HoaDonGoiDichVu h
		WHERE h.MaKhachHang = @MaKH AND h.NgayBatDau = NULL AND h.TenGoi = @TenGoi) > 0)
		BEGIN
			SELECT @ThoiHan = h.NgayGioMua FROM HoaDonGoiDichVu h
			WHERE h.MaKhachHang = @MaKH AND h.TenGoi = @TenGoi
			AND h.NgayGioMua = (SELECT MAX(NgayGioMua) FROM HoaDonGoiDichVu
			WHERE h.MaKhachHang = @MaKH AND h.NgayBatDau = NULL AND h.TenGoi = @TenGoi)
			SET @HanSuDung = DATEADD(DAY, 365, @ThoiHan)
		END;
	ELSE
		BEGIN
			SET @ThoiHan = (SELECT MAX(NgayBatDau) FROM HoaDonGoiDichVu
							WHERE MaKhachHang = @MaKH AND TenGoi = @TenGoi)
			SET @HanSuDung = DATEADD(DAY, @SoNgay, @ThoiHan)
		END;
	IF (@NgayGioMua > @HanSuDung)
		BEGIN
			INSERT INTO HoaDonGoiDichVu(MaKhachHang, TenGoi, NgayGioMua, NgayBatDau, TongTien)
			VAlUES (@MaKH, @TenGoi, @NgayGioMua, @NgayBatDau, @GiaGoi)
		END;
	ELSE
		RAISERROR(N'Bạn không thể mua gói này.', 10, 1)
END
GO

INSERT INTO HoaDonGoiDichVu(MaKhachHang, TenGoi, NgayGioMua, NgayBatDau, TongTien)
VAlUES ('KH222222','GOI B', '2021-12-14 08:00:00', '2021-12-30 22:45:00', 20000)

INSERT INTO HoaDonGoiDichVu(MaKhachHang, TenGoi, NgayGioMua, NgayBatDau, TongTien)
VAlUES ('KH222222','GOI B', '2020-11-30 08:00:00', NULL, 20000)