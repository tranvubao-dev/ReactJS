import { Link } from 'react-router-dom';
import img1 from '../../assets/images/bg-hero.jpg'
import './login.scss';
import { Form, Input, Button, Checkbox } from 'antd';
const image = { url: '../../assets/' }

function Login() {
    // const Login = () => {
    //     const onFinish = (values) => {
    //       console.log('Success:', values);
    //     };
      
    //     const onFinishFailed = (errorInfo) => {
    //       console.log('Failed:', errorInfo);
    //     };
    return (<>
    <div id="feature" className="block featureBlock bgGray">
        
        <div id="login" className="login-1">
            <div class="container" style={{ background: { img1 } }} >
                <div id="login-row" className="row justify-content-center align-items-center" >
                    <div id="login-column" class="col-md-12">
                        <div id="login-box" class="col-md-12">
                            <form id="login-form" class="form" action="" method="post">
                                <h3 class="text-dn">Đăng nhập tài khoản</h3>
                                <hr></hr>
                                <div class="form-group">
                                    <label for="username" class="text-label">Tên đăng nhập:</label><br />
                                    <input type="text" name="username" id="username" class="form-control" placeholder='Email' />
                                </div>
                                <br></br>
                                <div class="form-group">
                                    <label for="password" class="text-label">Mật khẩu:</label><br />
                                    <input type="text" name="password" id="password" class="form-control" placeholder='Mật khẩu' />
                                </div>
                                <div class="modify1">
                                    <br></br>
                                    <label >
                                        <input  name="remember-me" type="checkbox" />
                                        <span id="remembertext"> Ghi nhớ đăng nhập </span>
                                        <a class="qmk" href='#'>Quên mật khẩu</a>
                                    </label>
                                    <br></br>
                                    <br></br>
                                </div>
                                <div class="modify2">
                                    <input type="submit" name="submit" class="btnsubmit" value="Đăng nhập" />
                                </div>

                                <div id="register-link" class="text-right">
                                    <br></br>
                                    <label>Bạn chưa có tài khoản? </label>
                                    <Link to="../register"> Đăng ký</Link>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </>);
}

export default Login;