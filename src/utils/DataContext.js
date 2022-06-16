import { useState, useEffect, createContext } from 'react'
import { Rate } from 'antd';
export const DataContext = createContext()
const dataPost = [
    {
      id: 1,
      tieude: 'Phòng trọ vip',
      diachi: 'Quy Nhơn, Bình Định',
      gia: 600,
      donvi: 'nghìn vnđ/tháng',
      mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
      nguoidang: 'bacvu',
      img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
      img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
      img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
      img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
      trangthai: 0,
      danhgia:<Rate defaultValue={3}/>,
      dientich:'20m2'
    },
    {
      id: 2,
      tieude: 'Phòng trọ mini',
      diachi: 'BMT, Đắk Lắk',
      gia: 500,
      donvi: 'nghìn vnđ/tháng',
      mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
      nguoidang: 'thonguyen',
      img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
      img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
      img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
      img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
      trangthai: 1
    },
    {
      id: 3,
      tieude: 'Phòng trọ BMT',
      diachi: 'BMT, Đắk Lắk',
      gia: 600,
      donvi: 'nghìn vnđ/tháng',
      mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
      nguoidang: 'diepdang',
      img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
      img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
      img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
      img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
      trangthai: 1
    },
    {
      id: 4,
      tieude: 'Phòng trọ giá tốt',
      diachi: 'Q12, Hồ Chí Minh',
      gia: 800,
      donvi: 'nghìn vnđ/tháng',
      mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
      nguoidang: 'anhthu',
      img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
      img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
      img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
      img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
      trangthai: 0
    },
    {
        id: 5,
        tieude: 'Phòng trọ vip',
        diachi: 'Quy Nhơn, Bình Định',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'bacvu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 6,
        tieude: 'Phòng trọ mini',
        diachi: 'BMT, Đắk Lắk',
        gia: 500,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'thonguyen',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 7,
        tieude: 'Phòng trọ BMT',
        diachi: 'BMT, Đắk Lắk',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'diepdang',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 8,
        tieude: 'Phòng trọ giá tốt',
        diachi: 'Q12, Hồ Chí Minh',
        gia: 800,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'anhthu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 9,
        tieude: 'Phòng trọ vip',
        diachi: 'Quy Nhơn, Bình Định',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'bacvu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      },
      {
        id: 10,
        tieude: 'Phòng trọ mini',
        diachi: 'BMT, Đắk Lắk',
        gia: 500,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'thonguyen',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      },
      {
        id: 11,
        tieude: 'Phòng trọ BMT',
        diachi: 'BMT, Đắk Lắk',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'diepdang',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 12,
        tieude: 'Phòng trọ giá tốt',
        diachi: 'Q12, Hồ Chí Minh',
        gia: 800,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'anhthu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 13,
        tieude: 'Phòng trọ vip',
        diachi: 'Quy Nhơn, Bình Định',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'bacvu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      },
      {
        id: 14,
        tieude: 'Phòng trọ mini',
        diachi: 'BMT, Đắk Lắk',
        gia: 500,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'thonguyen',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 15,
        tieude: 'Phòng trọ BMT',
        diachi: 'BMT, Đắk Lắk',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'diepdang',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 16,
        tieude: 'Phòng trọ giá tốt',
        diachi: 'Q12, Hồ Chí Minh',
        gia: 800,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'anhthu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      },
      {
        id: 17,
        tieude: 'Phòng trọ vip',
        diachi: 'Quy Nhơn, Bình Định',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'bacvu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      },
      {
        id: 18,
        tieude: 'Phòng trọ mini',
        diachi: 'BMT, Đắk Lắk',
        gia: 500,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'thonguyen',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 19,
        tieude: 'Phòng trọ BMT',
        diachi: 'BMT, Đắk Lắk',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'diepdang',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      },
      {
        id: 20,
        tieude: 'Phòng trọ giá tốt',
        diachi: 'Q12, Hồ Chí Minh',
        gia: 800,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'anhthu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      },
      {
        id: 21,
        tieude: 'Phòng trọ vip',
        diachi: 'Quy Nhơn, Bình Định',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'bacvu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      },
      {
        id: 22,
        tieude: 'Phòng trọ mini',
        diachi: 'BMT, Đắk Lắk',
        gia: 500,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'thonguyen',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 1
      },
      {
        id: 23,
        tieude: 'Phòng trọ BMT',
        diachi: 'BMT, Đắk Lắk',
        gia: 600,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'diepdang',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      },
      {
        id: 24,
        tieude: 'Phòng trọ giá tốt',
        diachi: 'Q12, Hồ Chí Minh',
        gia: 800,
        donvi: 'nghìn vnđ/tháng',
        mota: 'Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm.',
        nguoidang: 'anhthu',
        img1: 'https://afamilycdn.com/150157425591193600/2020/9/6/2-15993881710591920233797.jpg',
        img2: 'https://xaynhatro.net/wp-content/uploads/2018/06/f70f05c965f280acd9e3.jpg',
        img3: 'https://bandon.vn/uploads/thiet-ke-nha-tro-dep-2020-bandon-11.jpg',
        img4: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkpKimrec6en61zfIC1FOLvdpSRAf5dbYgqQ&usqp=CAU',
        trangthai: 0
      }
  ];
const dataUser = [
    {
      id: 1,
      hovaten: 'Vũ Xuân Bắc',
      tendangnhap: 'bacvu',
      tuoi: 22,
      gioitinh: 'nam',
      diachi: 'Đắk Lắk',
      gmail: 'vubacbds@gmail.com',
      sdt: '0868609878',
      quyen: 1,
      img: 'https://pdp.edu.vn/wp-content/uploads/2021/05/hinh-anh-avatar-nam-1-600x600.jpg',
      fb: 'https://fb.com/profiles?id=bac',
    },
    {
      id: 2,
      hovaten: 'Đặng Thị Diệp',
      tendangnhap: 'diepdang',
      tuoi: 22,
      gioitinh: 'nu',
      diachi: 'Hà Nội',
      gmail: 'diepdang@gmail.com',
      sdt: '0936785671',
      quyen: 0,
      img: 'https://xinhstar.vn/wp-content/uploads/2020/08/21.jpg',
      fb: '',
    },
    {
        id: 3,
        hovaten: 'Nguyễn Đình Thọ',
        tendangnhap: 'thonguyen',
        tuoi: 22,
        gioitinh: 'nam',
        diachi: 'Đắk Lắk',
        gmail: 'ndtho@gmail.com',
        sdt: '098785686',
        quyen: 1,
        img: 'https://phunugioi.com/wp-content/uploads/2021/10/Hinh-anh-chibi-superman-dep.jpg',
        fb: 'https://fb.com/profiles?id=tho',
    },
    {
        id: 4,
        hovaten: 'Anh Thư',
        tendangnhap: 'thonguyen',
        tuoi: 18,
        gioitinh: 'nu',
        diachi: 'Hồ Chí Minh',
        gmail: 'anhthu@gmail.com',
        sdt: '0987856666',
        quyen: 0,
        img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7dwgCJqfs9Gp3SR7D0TQ87kLrpM6CYr1Viw&usqp=CAU',
        fb: 'https://fb.com/profiles?id=thu',
    }
  ];
function DataProvider({children}) {
    const [dataSource, setDataSource] = useState([])
    const [dataSourceUser, setDataSourceUser] = useState(dataUser)
    useEffect(() => {
        setDataSource(dataPost)
    },[])
   
    const dataDaDang = dataSource.filter( item => {  
        return item.trangthai === 1;
    })

    const dataChoDuyet = dataSource.filter( item => {  
        return item.trangthai === 0;
    })

    const value = {
        dataDaDang, dataChoDuyet, dataSource, setDataSource, 
        dataSourceUser, setDataSourceUser
    }
    return (
        <DataContext.Provider value={value}>
            {children}
        </DataContext.Provider>
    )
}
export default DataProvider 