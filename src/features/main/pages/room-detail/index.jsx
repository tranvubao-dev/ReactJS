import React from 'react';
import RoomsInfo from '../rooms-info';
import DetailsInfoRoom from './details-info-room';
import Comment from './comment-review';
import AppCarousel from '../carousel';
import image1 from '../../../../assets/images/modern-design.jpg';
import image2 from '../../../../assets/images/clean-design.jpg';
import image3 from '../../../../assets/images/great-support.jpg';
const items = [
  {
    key: '1',
    title: 'Modern Design',
    image: image1
  },
  {
    key: '2',
    title: 'Clean and Elegant',
    image: image2
  },
  {
    key: '3',
    title: 'Great Support',
    image: image3
  }
];
const roomDetail = {
  id: 'facd0009as9fffff-feidws456',
  title: 'Easy to customise',
  detail: '',
  images: [
    'https://sncdn.com/imagecache/db/id/11587/6783564a.jpg',
    'https://images.trvl-media.com/hotels/1000000/10000/5400/5363/d44a63cd_z.jpg',
    'https://content.r9cdn.net/himg/f5/94/af/leonardo-178075906-Hyatt-Ziva-Los-Cabos-Club-Ocean-View-Master-Double_O-343218.jpg'
  ]
};
const dataCarousel = roomDetail.images.map(item =>{
  return {image: item, key: Math.random()};
});
function RoomDetail() {
  return (
    <div id="feature" className="block featureBlock bgGray">
      <div className="container-fluid">
        <div className="titleHolder">
          <h2>{roomDetail.title}</h2>
        </div>
        <AppCarousel data={dataCarousel} />
        <div>
          <h4 className="titleHolder marginTop">Thông tin chi tiết phòng trọ</h4>
          <DetailsInfoRoom />
          <div className='box'>
            <div className='titleHolder'>Mô tả chi tiết</div>
            KHAI TRƯƠNG PHÒNG CHO THUÊ NGAY NGÃ TƯ GÒ MÂY VỚI GIÁ SIÊU RẺ 🌟<br />
            Giá : 2tr6 - 3tr2 ( ban công riêng ) ❌<br />
            ❌ Nội thất : Máy lạnh , Tủ quần áo , Tủ bếp trên - bếp dưới , Nước nóng NLMT <br />
            🚦Vị trí : Nằm ngã tư gò mây thuận tiện sang ĐH Hufi , đường Phạm Đăng Giảng , Lê Trọng Tấn , Trường Chinh , Kênh 19/5 , Aeon Tân Phú <br />
            KHAI TRƯƠNG PHÒNG CHO THUÊ NGAY NGÃ TƯ GÒ MÂY VỚI GIÁ SIÊU RẺ 🌟<br />
            Giá : 2tr6 - 3tr2 ( ban công riêng ) ❌ <br />

            ❌ Nội thất : Máy lạnh , Tủ quần áo , Tủ bếp trên - bếp dưới , Nước nóng NLMT<br />

            🚦Vị trí : Nằm ngã tư gò mây thuận tiện sang ĐH Hufi , đường Phạm Đăng Giảng , Lê Trọng Tấn , Trường Chinh , Kênh 19/5 , Aeon Tân Phú<br />

            🎁 Tiện ích :<br />
            ➡️ Phòng mới sạch sẽ, rộng rãi, mới xây<br />
            ➡️ Trang bị đầy đủ tiện nghi<br />
            ➡️ Giờ giấc tự do, không chung chủ<br />
            ➡️ Máy giặt chung, camera an ninh, wifi, vệ sinh hành lang thường xuyên , cửa vân tay<br />
            ➡️ Bãi giữ xe rộng rãi<br />

            ❌ Chi phí hợp lí :<br />
            ⚡️ Điện : 3,5k/Kwh<br />
            💦 Nước : 100k/người<br />
            🏍 Xe : Free<br />
            ✨ Phí dịch vụ : 100k/phòng<br />

            ❌ Tăng 400.000/tháng đến khi làm gác<br />

            💥 PHÒNG HOT PHÒNG HOT LIÊN HỆ NHANH ĐỂ CÓ PHÒNG VỊ TRÍ ĐẸP NHẤT 💥<br />
            ----------------------------------------------<br />
            ☎️ Điện thoại liên hệ:<br />
          </div>
          <div className='marginTop'>
            <RoomsInfo title='Phòng tương thích' data={items} />
          </div>

          <h4 className='marginTop'>Bình luận</h4>
          <Comment />
        </div>
      </div>
    </div>
  );
}
export default RoomDetail
