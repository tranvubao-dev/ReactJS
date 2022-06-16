import './Register.scss'
import { Link } from 'react-router-dom';
import img1 from '../../assets/images/bg-hero.jpg'
import { Form, Input, Button, Checkbox } from 'antd';
const image = { url: '../../assets/' }
const Register = () => {
    return ( 
        <>
    <div id="feature" className="block featureBlock bgGray">
        <div className="container_register">
        <div id="login" className="login-1">
            <div class="container" style={{ background: { img1 } }} >
                <div id="login-row" className="row justify-content-center align-items-center" >
                    <div id="login-column" class="col-md-12">
                        <div id="login-box" class="col-md-12">
                            <form id="login-form" class="form" action="" method="post">
                                <h3 class="text-dn">Đăng ký tài khoản</h3>
                                <hr></hr>
                                <div class="form-group">
                                    <label for="username" class="text-label">Tôi là:</label>
                                    <select class="form-control">
                                         <option value="0">Chủ trọ</option>
                                         <option value="1">Khách hàng</option>
                                    </select>
                                    <br />
                                    <label class="toila">Tên đăng nhập</label>
                                     <input class="form-control" type="text" name="email" id="email" required></input>
                                     <br></br>
                                     <label class ="toila" for="psw">Mật khẩu</label>
                                     <input class="form-control" type="password" name="psw" id="psw" required></input>
                                     <br></br>
                                     <label class="toila" for="psw-repeat">Xác thực mật khẩu</label>
                                    <input class="form-control" type="password" name="psw-repeat" id="psw-repeat" required></input>
                                    <br></br>
                                    <label class="toila">Họ và tên</label>
                                   <input  class="form-control" type="text" placeholder="Họ và tên" name="email" id="email" required></input>
                                    <br></br>
                                    <fieldset class="form-control">
                                 <label class="toila">Giới tính</label>
                                 <div class="sex">
                                     <input type="radio" name="sex" id="sex-m" value="m"></input>
                                     <label for="sex-m">Male</label>
                                     <input class="marnam" type="radio" name="sex" id="sex-f" value="f"></input>
                                     <label for="sex-f">Female</label>
                                 </div>
                             </fieldset>
                             <br></br>
                             <label >Ngày sinh</label>
                             <input class="form-control" type="date"></input>
                             <br></br>
                             <label class="toila">Số điện thoại</label>
                             <input class="form-control" type="text" placeholder="Enter sđt" name="email" id="email" required></input>
                             <br></br>
                             <label class="toila">Gmail</label>
                             <input class="form-control" type="text" placeholder="Enter gmail" name="email" id="email" required></input>
                             <hr></hr>
                             <p class="accept"><input type="checkbox"></input> Tôi chấp nhận điều kiện và các chính sách riêng tư.</p>
                              <div class="flex-btn"><button type="submit" class="registerbtn">Đăng ký</button></div>
                                    
                                </div>
                                
                               
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
        </div>
    </>
    )
}
 
export default Register;