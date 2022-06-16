import React, { useState } from 'react';

import { Anchor, Drawer, Button } from 'antd';

const { Link } = Anchor;

function MainLayout() {
  const [visible, setVisible] = useState(false);

  const showDrawer = () => {
    setVisible(true);
  };

  const onClose = () => {
    setVisible(false);
  };

  return (
    <div className="container-fluid">
      <div className="header">
        <div className="logo">
          <i className="fas fa-bolt"></i>
          <a href="/">Room Social Network</a>
        </div>
        <div className="mobileHidden">
          <Anchor targetOffset="65">
            <Link href="/" title="Trang chủ" />
            <Link href="/about" title="Giới thiệu" />
            <Link href="/detail" title="Thông tin phòng trọ" />
            <Link href="/works" title="Liên hệ" />
            <Link href="/room-social-network/Login"  title="Đăng nhập" />
            <Link href="/pricing" title="Pricing" />
            <Link href="/contact" title="Contact" />
            <Link href="/news" title="News" />
          </Anchor>
        </div>
        <div className="mobileVisible">
          <Button type="primary" onClick={showDrawer}>
            <i className="fas fa-bars"></i>
          </Button>
          <Drawer
            placement="right"
            closable={false}
            onClose={onClose}
            visible={visible}
          >
            <Anchor targetOffset="65">
              <Link href="/" title="Home" />
              <Link href="/about" title="About" />
              <Link href="/detail" title="Features" />
              <Link href="/works" title="How it works" />
              <Link href="/faq" title="FAQ" />
              <Link href="/pricing" title="Pricing" />
              <Link href="/contact" title="Contact" />
              <Link href="/news" title="News" />
            </Anchor>
          </Drawer>
        </div>
      </div>
    </div>
  );
}

export default MainLayout;