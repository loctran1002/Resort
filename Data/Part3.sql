USE RESORT
GO

CREATE LOGIN sManager WITH PASSWORD = 'Resort123';
CREATE USER sManager FOR LOGIN sManager;
GO

GRANT ALL ON CungCapVatTu TO sManager
GRANT ALL ON ChiNhanh TO sManager
GRANT ALL ON ChiNhanhCoLoaiPhong TO sManager
GRANT ALL ON DichVu TO sManager
GRANT ALL ON DichVuSpa TO sManager
GRANT ALL ON DoanhNghiep TO sManager
GRANT ALL ON DonDatPhong TO sManager
GRANT ALL ON GoiDichVu TO sManager
GRANT ALL ON HinhAnhCuaHang TO sManager
GRANT ALL ON HinhAnhChiNhanh TO sManager
GRANT ALL ON HoaDon TO sManager
GRANT ALL ON HoaDonGoiDichVu TO sManager
GRANT ALL ON KhachHang TO sManager
GRANT ALL ON Khu TO sManager
GRANT ALL ON KhungGioHoatDongCuaHang TO sManager
GRANT ALL ON LoaiHangDoLuuNiem TO sManager
GRANT ALL ON LoaiPhong TO sManager
GRANT ALL ON LoaiVatTu TO sManager
GRANT ALL ON LoaiVatTuTrongLoaiPhong TO sManager
GRANT ALL ON MatBang TO sManager
GRANT ALL ON NhaCungCap TO sManager
GRANT ALL ON Phong TO sManager
GRANT ALL ON PhongThue TO sManager
GRANT ALL ON ThongTinGiuong TO sManager
GRANT ALL ON THuongHieuDoLuuNiem TO sManager
GRANT ALL ON VatTu TO sManager
GRANT ALL ON ThongKeLuotKhach TO sManager
GRANT ALL ON GiamGia TO sManager
GRANT ALL ON KhuyenMai TO sManager
GRANT ALL ON GoiDichVufunction TO sManager
GO