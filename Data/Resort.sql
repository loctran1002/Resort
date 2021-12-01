USE master
GO

DROP DATABASE IF EXISTS RESORT
GO

CREATE DATABASE RESORT
GO

USE RESORT
GO

CREATE TABLE ChiNhanh(
	STT				INT IDENTITY,
	MaChiNhanh AS('CN' + CAST(STT AS VARCHAR(5))) PERSISTED PRIMARY KEY,
	Tinh			NVARCHAR(30)		NOT NULL,
	DiaChi			NVARCHAR(100)		NOT NULL,
	DienThoai		VARCHAR(11)			NOT NULL,
	Email			VARCHAR(50)
);

CREATE TABLE HinhAnhChiNhanh(
	MaChiNhanh		VARCHAR(7)			NOT NULL,
	HinhAnh			VARCHAR(200)		NOT NULL,
	PRIMARY KEY	(MaChiNhanh, HinhAnh),
	CONSTRAINT MaChiNhanh_HinhAnhChiNhanh FOREIGN KEY (MaChiNhanh)
		REFERENCES ChiNhanh(MaChiNhanh)
);

CREATE TABLE Khu(
	MaChiNhanh		VARCHAR(7),
	TenKhu			NVARCHAR(30),
	PRIMARY KEY	(MaChiNhanh, TenKhu),
	CONSTRAINT MaChiNhanh_Khu FOREIGN KEY (MaChiNhanh)
		REFERENCES ChiNhanh(MaChiNhanh)
);

CREATE TABLE LoaiPhong(
	MaLoaiPhong		INT		IDENTITY(1, 1)	PRIMARY KEY,
	TenLoaiPhong	NVARCHAR(30),
	DienTich		FLOAT,
	SoKhach			TINYINT			NOT NULL	CHECK(SoKhach>=1 AND SoKhach<=10),
	MoTaKhac		NVARCHAR(150)
);

CREATE TABLE ThongTinGiuong(
	MaLoaiPhong		INT				NOT NULL,
	KichThuoc		DECIMAL(2,1)	NOT NULL,
	SoLuong			TINYINT			NOT NULL CHECK(SoLuong>=1 AND SoLuong<=10) DEFAULT(1),
	PRIMARY KEY	(MaLoaiPhong, KichThuoc),
	CONSTRAINT MaChiNhanh_ThongTinGiuong FOREIGN KEY (MaLoaiPhong)
		REFERENCES LoaiPhong(MaLoaiPhong)
);

CREATE TABLE ChiNhanhCoLoaiPhong(
	MaLoaiPhong		INT				NOT NULL,
	MaChiNhanh		VARCHAR(7)		NOT NULL,
	GiaThue			DECIMAL(10,2)	NOT NULL,
	PRIMARY KEY	(MaLoaiPhong, MaChiNhanh),
	CONSTRAINT MaLoaiPhong_ChiNhanhCoLoaiPhong FOREIGN KEY (MaLoaiPhong)
		REFERENCES LoaiPhong(MaLoaiPhong),
	CONSTRAINT MaChiNhanh_ChiNhanhCoLoaiPhong FOREIGN KEY (MaChiNhanh)
		REFERENCES ChiNhanh(MaChiNhanh)
);

CREATE TABLE Phong(
	MaChiNhanh		VARCHAR(7)		NOT NULL,
	SoPhong			CHAR(3)			NOT NULL,
	MaLoaiPhong		INT				NOT NULL,
	TenKhu			NVARCHAR(30)	NOT NULL,
	PRIMARY KEY	(MaChiNhanh, SoPhong),
	CONSTRAINT MaChiNhanh_Phong FOREIGN KEY (MaChiNhanh)
		REFERENCES ChiNhanh(MaChiNhanh),
	CONSTRAINT "MaChiNhanh, TenKhu_Phong" FOREIGN KEY (MaChiNhanh, TenKhu)				/* ******************* */
		REFERENCES Khu(MaChiNhanh, TenKhu),
	CONSTRAINT MaLoaiPhong_Phong FOREIGN KEY (MaLoaiPhong)
		REFERENCES LoaiPhong(MaLoaiPhong)
);

CREATE TABLE LoaiVatTu(
	MaLoaiVatTu		CHAR(6)		CHECK(MaLoaiVatTu LIKE 'VT[0-9][0-9][0-9][0-9]'),
	TenLoaiVatTu	NVARCHAR(30),
	PRIMARY KEY	(MaLoaiVatTu)
);

CREATE TABLE LoaiVatTuTrongLoaiPhong(
	MaLoaiVatTu		CHAR(6)			NOT NULL,
	MaLoaiPhong		INT				NOT NULL,
	SoLuong			TINYINT			NOT NULL CHECK(SoLuong>=1 AND SoLuong<=20) DEFAULT(1),
	PRIMARY KEY	(MaLoaiVatTu,MaLoaiPhong),
	CONSTRAINT MaLoaiVatTu_LoaiVatTuTrongLoaiPhong FOREIGN KEY (MaLoaiVatTu)
		REFERENCES LoaiVatTu(MaLoaiVatTu),
	CONSTRAINT MaLoaiPhong_LoaiVatTuTrongLoaiPhong FOREIGN KEY (MaLoaiPhong)
		REFERENCES LoaiPhong(MaLoaiPhong)
);

CREATE TABLE VatTu (
	MaChiNhanh		VARCHAR(7)		NOT NULL,
	MaLoaiVatTu		CHAR(6)			NOT NULL,
	STTVatTu		INT		CHECK(STTVatTu>0),
	TinhTrang		NVARCHAR(100),
	SoPhong			CHAR(3),
	PRIMARY KEY	(MaChiNhanh,MaLoaiVatTu,STTVatTu),
	CONSTRAINT MaChiNhanh_VatTu FOREIGN KEY (MaChiNhanh)
		REFERENCES ChiNhanh(MaChiNhanh),
	CONSTRAINT MaLoaiVatTu_VatTu FOREIGN KEY (MaLoaiVatTu)
		REFERENCES LoaiVatTu(MaLoaiVatTu),
	CONSTRAINT "MaChiNhanh, SoPhong_VatTu" FOREIGN KEY (MaChiNhanh,SoPhong)				/*88888888888888888888*/
		REFERENCES Phong(MaChiNhanh,SoPhong)
);

CREATE TABLE NhaCungCap(
	MaNhaCungCap	CHAR(7)		CHECK(MaNhaCungCap LIKE 'NCC[0-9][0-9][0-9][0-9]'),
	TenNhaCungCap	NVARCHAR(100)	NOT NULL,
	Email			VARCHAR(50),
	DiaChi			NVARCHAR(100),
	PRIMARY KEY	(MaNhaCungCap)
);

CREATE TABLE CungCapVatTu (
	MaNhaCungCap	CHAR(7)			NOT NULL,
	MaLoaiVatTu		CHAR(6)			NOT NULL,
	MaChiNhanh		VARCHAR(7)	FOREIGN KEY REFERENCES ChiNhanh(MaChiNhanh),
	PRIMARY KEY	(MaLoaiVatTu, MaChiNhanh),
	CONSTRAINT MaNhaCungCap_CungCapVatTu FOREIGN KEY (MaNhaCungCap)
		REFERENCES NhaCungCap(MaNhaCungCap),
	CONSTRAINT MaLoaiVatTu_CungCapVatTu FOREIGN KEY (MaLoaiVatTu)
		REFERENCES LoaiVatTu(MaLoaiVatTu),
);

CREATE TABLE KhachHang(
	MaKhachHang		CHAR(8)			CHECK(MaKhachHang LIKE 'KH[0-9][0-9][0-9][0-9][0-9][0-9]'),
	CCCD_CMND		VARCHAR(12)		NOT NULL UNIQUE,
	HoTen			NVARCHAR(30)	NOT NULL,
	DienThoai		VARCHAR(11)		NOT NULL UNIQUE,
	Email			VARCHAR(50)		UNIQUE,
	Username		VARCHAR(100)	NOT NULL UNIQUE,
	Pass			VARBINARY(1024)	NOT NULL UNIQUE,
	Diem			INT				NOT NULL CHECK(Diem>=0) DEFAULT(0),
	Loai			TINYINT			NOT NULL CHECK(Loai>=1 AND Loai<=4) DEFAULT(1),
	SoNgayCongThem	TINYINT			DEFAULT(0),
	PRIMARY KEY	(MaKhachHang)
);
GO

DROP TRIGGER IF EXISTS Encrypt
GO

CREATE TRIGGER Encrypt
ON KhachHang
FOR INSERT
AS
BEGIN
	DECLARE @id		CHAR(8),
			@pass	VARBINARY(1024),
			@str	VARCHAR(100);
	SELECT @id = MaKhachHang FROM INSERTED
	SELECT @str = 'No pain, no gain!!'
	SELECT @pass = Pass FROM INSERTED
	UPDATE KhachHang SET Pass = ENCRYPTBYPASSPHRASE(@str, @pass) WHERE MaKhachHang = @id
END
GO

CREATE TABLE GoiDichVu(
	TenGoi			VARCHAR(100)	NOT NULL PRIMARY KEY,
	SoNgay			TINYINT			NOT NULL  CHECK(SoNgay>=1 AND SoNgay<=100),
	SoKhach			TINYINT			NOT NULL  CHECK(SoKhach>=1 AND SoKhach<=10),
	Gia				DECIMAL(10,2)	NOT NULL
);

CREATE TABLE HoaDonGoiDichVu(
	MaKhachHang		CHAR(8)			NOT NULL,
	TenGoi			VARCHAR(100)	NOT NULL,
	NgayGioMua		DATETIME		NOT NULL,
	NgayBatDau		DATETIME,
	TongTien		DECIMAL(10,2)	NOT NULL,
	CHECK (NgayBatDau>NgayGioMua),
	PRIMARY KEY	(MaKhachHang,TenGoi,NgayGioMua),
	CONSTRAINT MaKhachHang_HoaDonGoiDichVu FOREIGN KEY (MaKhachHang)
		REFERENCES KhachHang(MaKhachHang),
	CONSTRAINT TenGoi_HoaDonGoiDichVu FOREIGN KEY (TenGoi)
		REFERENCES GoiDichVu(TenGoi)
);
GO

CREATE FUNCTION [dbo].[AUTO_ID] ()
RETURNS VARCHAR(16)
AS
BEGIN
	DECLARE @id		VARCHAR(16),
			@time	VARCHAR(8)
	SET @time = (SELECT FORMAT(GETDATE(), 'ddMMyyyy'))
	SET @id = RIGHT('00000' + CONVERT(VARCHAR, (SELECT COUNT(MaDatPhong) FROM DonDatPhong) + 1), 6)
	SET @id = 'DP' + CONVERT(VARCHAR, @time) + @id
	RETURN @id
END
GO

CREATE TABLE DonDatPhong (
	MaDatPhong		CHAR(16)	PRIMARY KEY CONSTRAINT IdBill DEFAULT DBO.AUTO_ID(),
	NgayGioDat		DATETIME		NOT NULL,
	SoKhach			INT				NOT NULL,
	NgayNhanPhong	DATETIME		NOT NULL,
	NgayTraPhong	DATETIME		NOT NULL,
	TinhTrang		TINYINT			NOT NULL CHECK(TinhTrang>=0 AND TinhTrang<=3),
	TongTien		DECIMAL(10,2)	NOT NULL DEFAULT(0),
	MaKhachHang		CHAR(8)			NOT NULL,
	TenGoiDichVu	VARCHAR(100)	,
	CHECK	(NgayNhanPhong>NgayGioDat AND NgayTraPhong>NgayNhanPhong),
	CONSTRAINT MaKhachHang_DonDatPhong FOREIGN KEY (MaKhachHang)
		REFERENCES KhachHang(MaKhachHang),
	CONSTRAINT TenGoiDichVu_DonDatPhong FOREIGN KEY (TenGoiDichVu)
		REFERENCES GoiDichVu(TenGoi)
);

CREATE TABLE PhongThue(
	MaDatPhong		CHAR(16)		NOT NULL,
	MaChiNhanh		VARCHAR(7)		NOT NULL,
	SoPhong			CHAR(3)			NOT NULL,
	PRIMARY KEY	(MaDatPhong,MaChiNhanh,SoPhong),
	CONSTRAINT MaDatPhong_PhongThue FOREIGN KEY (MaDatPhong)
		REFERENCES DonDatPhong(MaDatPhong),
	CONSTRAINT "MaChiNhanh, SoPhong_PhongThue" FOREIGN KEY (MaChiNhanh, SoPhong)		/*88888888888888*/
		REFERENCES Phong(MaChiNhanh, SoPhong)
);
GO

CREATE FUNCTION [dbo].[HD_ID] ()
RETURNS VARCHAR(16)
AS
BEGIN
	DECLARE @id		VARCHAR(16),
			@time	VARCHAR(8)
	SET @time = (SELECT FORMAT(GETDATE(), 'ddMMyyyy'))
	SET @id = RIGHT('00000' + CONVERT(VARCHAR, (SELECT COUNT(MaHoaDon) FROM HoaDon) + 1), 6)
	SET @id = 'HD' + CONVERT(VARCHAR, @time) + @id
	RETURN @id
END
GO

CREATE TABLE HoaDon(
	MaHoaDon			CHAR(16)	PRIMARY KEY		DEFAULT	DBO.HD_ID(),
	ThoiGianNhanPhong	CHAR(5)		CHECK(ThoiGianNhanPhong LIKE '[0-9][0-9][:][0-9][0-9]'),
	ThoiGianTraPhong	CHAR(5)		CHECK(ThoiGianTraPhong LIKE '[0-9][0-9][:][0-9][0-9]'),
	MaDatPhong			CHAR(16)	NOT NULL	UNIQUE,
	CONSTRAINT MaDatPhong_HoaDon FOREIGN KEY (MaDatPhong)
		REFERENCES DonDatPhong(MaDatPhong)
);

CREATE TABLE DoanhNghiep (
	MaDoanhNghiep	CHAR(6)		CHECK(MaDoanhNghiep LIKE 'DN[0-9][0-9][0-9][0-9]'),
	TenDoanhNghiep	NVARCHAR(30)	NOT NULL,
	PRIMARY KEY	(MaDoanhNghiep)
);

CREATE TABLE DichVu(
	MaDichVu		CHAR(6)		CHECK(MaDichVu like 'DV[R|S|C|M|B][0-9][0-9][0-9]'),
	LoaiDichVu		CHAR(1)			NOT NULL CHECK(LoaiDichVu like '[R|S|C|M|B]'),
	SoKhach			INT				NOT NULL,
	PhongCach		NVARCHAR(100),
	MaDoanhNghiep	CHAR(6)			NOT NULL,
	PRIMARY KEY	(MaDichVu),
	CONSTRAINT MaDoanhNghiep_DichVu FOREIGN KEY (MaDoanhNghiep)
		REFERENCES DoanhNghiep(MaDoanhNghiep)
);

CREATE TABLE DichVuSpa(
	MaDichVu		CHAR(6)		CHECK(MaDichVu LIKE 'DVS[0-9][0-9][0-9]'),
	DichVuSpa		NVARCHAR(100),
	PRIMARY KEY	(MaDichVu,DichVuSpa),
	CONSTRAINT MaDichVu_DichVuSpa FOREIGN KEY (MaDichVu)
		REFERENCES DichVu(MaDichVu)
);

CREATE TABLE LoaiHangDoLuuNiem(
	MaDichVu		CHAR(6)		CHECK(MaDichVu LIKE 'DVM[0-9][0-9][0-9]'),
	LoaiHang		NVARCHAR(100),
	PRIMARY KEY	(MaDichVu,LoaiHang),
	CONSTRAINT MaDichVu_LoaiHangDoLuuNiem FOREIGN KEY (MaDichVu)
		REFERENCES DichVu(MaDichVu)
);

CREATE TABLE ThuongHieuDoLuuNiem(
	MaDichVu		CHAR(6)		CHECK(MaDichVu LIKE 'DVM[0-9][0-9][0-9]'),
	ThuongHieu		NVARCHAR(100),
	PRIMARY KEY	(MaDichVu,ThuongHieu),
	CONSTRAINT MaDichVu_ThuongHieuDoLuuNiem FOREIGN KEY (MaDichVu)
		REFERENCES DichVu(MaDichVu)
);

CREATE TABLE MatBang(
	MaChiNhanh		VARCHAR(7),
	STTMatBang		TINYINT		CHECK(STTMatBang>=1 AND STTMatBang<=50) DEFAULT(1),
	ChieuDai		FLOAT			NOT NULL	CHECK(ChieuDai>0),
	ChieuRong		FLOAT			NOT NULL	CHECK(ChieuRong>0),
	GiaThue			DECIMAL(10,2)	NOT NULL, 
	MoTa			NVARCHAR(100),
	MaDichVu		CHAR(6)			NOT NULL,
	TenCuaHang		NVARCHAR(30)		NOT NULL,
	Logo			VARCHAR(200),
	PRIMARY KEY	(MaChiNhanh, STTMatBang),
	CONSTRAINT MaChiNhanh_MatBang FOREIGN KEY (MaChiNhanh)
		REFERENCES ChiNhanh(MaChiNhanh),
	CONSTRAINT MaDichVu_MatBang FOREIGN KEY (MaDichVu)
		REFERENCES DichVu(MaDichVu)
);

CREATE TABLE HinhAnhCuaHang(
	MaChiNhanh		VARCHAR(7),
	STTMatBang		TINYINT,
	HinhAnh			VARCHAR(200),
	PRIMARY KEY	(MaChiNhanh, STTMatBang, HinhAnh),
	CONSTRAINT "MaChiNhanh, STTMatBang_HinhAnhCuaHang" FOREIGN KEY (MaChiNhanh,STTMatBang)		/*88888888888888*/
		REFERENCES MatBang(MaChiNhanh,STTMatBang)
);

CREATE TABLE KhungGioHoatDongCuaHang(
	MaChiNhanh		VARCHAR(7),
	STTMatBang		TINYINT,
	GioBatDau		CHAR(5)		CHECK(GioBatDau LIKE '__%:%__' AND GioBatDau>='00:00' AND GioBatDau<'23:59'),
	GioKetThuc		CHAR(5)			NOT NULL CHECK(GioKetThuc LIKE '__%:%__' AND GioKetThuc>'00:00' AND GioKetThuc<='23:59'),
	PRIMARY KEY	(MaChiNhanh, STTMatBang, GioBatDau),
	CHECK(GioBatDau<GioKetThuc),
	CONSTRAINT "MaChiNhanh, STTMatBang_KhungGioHoatDongCuaHang" FOREIGN KEY (MaChiNhanh,STTMatBang)	/***8888888888*/
		REFERENCES MatBang(MaChiNhanh,STTMatBang)
);