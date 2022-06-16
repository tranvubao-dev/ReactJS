import React from 'react';
import { Row, Col } from 'antd';
import { Card } from 'antd';
const { Meta } = Card;

function RoomsInfo(props) {
  
  var items = props.data;
  const roomsInfo = items.map((item) => {
    return (
      <Col md={{ span: 8 }} key={item.key} >
        <a href="/room-social-network/detail/facd0009as9fffff-feidws456">
          <Card
            hoverable
            cover={<img alt={item.title} src={item.image} />}
          >
            <Meta title={item.title} />
            <div>Diện tích: 40m²</div>
            <div>Địa chỉ: {item.diachi}</div>
            <div>Đánh giá: ⭐️⭐️⭐️</div>
            <div>1.200.000đ/tháng</div>
          </Card>
        </a>
      </Col>
    )
  });
  return (
    <div className="container-fluid">
      <div className="titleHolder">
        <h2>{props.title}</h2>
        {props.desc ? <p>{props.desc}</p> : <></>}
      </div>
      <Row gutter={[16, 16]} >
        {roomsInfo}
      </Row>
    </div>
  );
}

export default RoomsInfo;