import "./Manapostnews.css"
import * as ReactDOM from 'react-dom';
import { CheckCircleOutlined,CloseSquareOutlined,ClockCircleOutlined,FormOutlined } from '@ant-design/icons';
import { Input } from 'antd';
const { Search } = Input;
const onSearch = value => console.log(value);
const Manapostnews = () => {
    return ( <div className="manager">
                    <h3>Quản lý tin đăng</h3>
                        <div className='manager-new' style={{height:400,width:800,marginLeft:300}}> 
                            <div id="f1">
                                <select id="sele">
                                        <option value="0">Tất cả tin đã đăng</option>
                                        <option value="1">Khách hàng</option>
                                </select>
                                <Search placeholder="input search text" 
                            onSearch={onSearch} 
                            style={{ width: 200,marginLeft:100,marginTop:4 }} 
                            />
                            </div>
                            <h6 style={{marginLeft:-300,fontSize: 15,marginTop:10}}>Có 3 tin đăng được tìm thấy</h6>
                            <table className="table" >
                                <thead className="thead-dark" >
                                    <tr >
                                    <th scope="col">Mã đăng tin</th>
                                    <th scope="col">Tiêu đề</th>
                                    <th scope="col">Trạng thái</th>
                                    <th scope="col">Ngày đăng</th>
                                    <th scope="col">Xứ lý</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">A010101</th>
                                        <td>Thuê phòng trọ</td>
                                        <td id="sttv"><CheckCircleOutlined /></td>
                                        <td>04/04/2021</td>
                                        <td><FormOutlined /></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">A749292</th>
                                        <td>Thuê nguyên</td>
                                        <td id="sttx"><CloseSquareOutlined /></td>
                                        <td>01/01/2022</td>
                                        <td><FormOutlined /></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">A024497</th>
                                        <td>Tìm người ở</td>
                                        <td id="stto"><ClockCircleOutlined /></td>
                                        <td>05/08/2022</td>
                                        <td><FormOutlined /></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                </div>
                                 
     );
}
 
export default Manapostnews;