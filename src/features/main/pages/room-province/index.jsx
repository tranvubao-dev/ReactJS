import React from 'react';
import { Row, Col, Image} from 'antd';
import img1 from "../../../../assets/images/unlimited-features.jpg"
import '../../index.scss';
import  { useState } from 'react';
function  RoomProvince (props){
    const [visible, setVisible] = useState(false);
    const Room_Province  = ()=> {
    //     <Image
    //     preview={{ visible: false }}
    //     width={"auto"}
    //     height={500}
    //     onClick={() => setVisible(true)}
    //   />
            return (<>
                        <Col span={4} >  
                            <Image title='Hà Nội' style={{height:260}} 
                            src="https://live.staticflickr.com/3333/3175831395_7361b4851c_n.jpg" />
                            </Col>  
                        <Col span={4} >
                            <Row >
                                <Image title='Lâm Đồng'  src="https://th.bing.com/th/id/OIP.ae3po-Zv_l04bozkpZ7HbgHaFj?pid=ImgDet&w=1024&h=768&rs=1" />
                            </Row>
                            <Row >
                                <Image title ="Khánh Hòa"src="https://th.bing.com/th/id/OIP.4TZzYtOTmzBw53Z8EvgG7wHaEK?pid=ImgDet&w=1280&h=720&rs=1" />
                            </Row>
                        </Col>  
                        <Col span={4} >
                        <Image title='Bình Dương' style={{height:260}} src="https://th.bing.com/th/id/OIP.tEV6mtiIy-rUebR8u81QWgHaDt?pid=ImgDet&rs=1" />
                        </Col>  
                        <Col span={4}>
                            <Row >
                                <Image style={{height:137}}title='Hải Phòng'  src="https://th.bing.com/th/id/R.89c68b9cabbbbb421ffca19a95ab4521?rik=bFZ4XFDQ%2behldw&pid=ImgRaw&r=0" />
                            </Row>
                             <Row >
                                <Image title ="Bà Rịa - Vũng Tàu"src="https://th.bing.com/th/id/OIP.BP4fYoRguIDh1L-jUZI_lgAAAA?pid=ImgDet&rs=1" />
                            </Row>
                        </Col>  
                        <Col span={4} >
                            <Image title='Hồ Chí Minh' style={{height:260}} src="https://live.staticflickr.com/3333/3175831395_7361b4851c_n.jpg" />
                        </Col>  
                        <Col span={4} >
                            <Image title='Quy Nhơn City' style={{height:260}} src="https://th.bing.com/th/id/R.1742abadb5bce65a001082cad478882c?rik=9jZni6EFE5wzrw&riu=http%3a%2f%2fwww.vietnamvisa-easy.com%2fblog%2fwp-content%2fuploads%2f2013%2f11%2fQuy-Nhon-travel-vietnam-visa-vietnam-embassy3.jpg&ehk=E5FDHwLUgaue6jlsxK%2fO4iMQYQpAs6J42ftkAACuTvA%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1" />
                        </Col>  
                    </>   
                    );
    }

    return(<div>
                <div className='titleRoomProvince'>
                    <h3 style={{color:"#660000"}}>{props.title}</h3>
                    <p>{props.desc}</p>
                </div>
                <Row  gutter={[16, 16]} >
                    <Room_Province />
                </Row>
            </div>
            );
}

export default RoomProvince;