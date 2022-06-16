import { Typography, Carousel, Col, Checkbox, Button, Row, Popover, Table, Popconfirm, Input, Space } from 'antd';
import Highlighter from 'react-highlight-words';
import { useEffect, useState, useContext } from 'react';
import { DeleteOutlined, SearchOutlined } from '@ant-design/icons';
import {DataContext} from '../../../../utils/DataContext'

function Post() {
    const dataSource = useContext(DataContext).dataDaDang
    const dataSourceTotal = useContext(DataContext).dataSource
    const setDataSource = useContext(DataContext).setDataSource
    const del = (idvao) => {
        console.log(idvao)
        try {
          const newData = [...dataSourceTotal];
          const index = newData.findIndex((item) => idvao === item.id);
          if (index > -1) {
            newData.splice(index, 1);
            setDataSource(newData);
          } 
        }
          catch (errInfo) {
          console.log('Validate Failed:', errInfo);
        }
      }
    //Xử lý tìm kiếm (mở)
    const [searchText, setSearchText] = useState('')
    const [searchedColumn, setSearchedColumn] = useState('')
    const getColumnSearchProps = dataIndex => ({
      filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters }) => (
        <div style={{ padding: 8 }}>
          <Input
            placeholder={`Search ${dataIndex}`}
            value={selectedKeys[0]}
            onChange={e => setSelectedKeys(e.target.value ? [e.target.value] : [])}
            onPressEnter={() => handleSearch(selectedKeys, confirm, dataIndex)}
            style={{ marginBottom: 8, display: 'block' }}
          />
          <Space>
            <Button
              type="primary"
              onClick={() => handleSearch(selectedKeys, confirm, dataIndex)}
              icon={<SearchOutlined />}
              size="small"
              style={{ width: 90 }}
            >
              Search
            </Button>
            <Button onClick={() => handleReset(clearFilters)} size="small" style={{ width: 90 }}>
              Reset
            </Button>
            <Button
              type="link"
              size="small"
              onClick={() => {
                confirm({ closeDropdown: false });
                setSearchText(selectedKeys[0])
                setSearchedColumn(dataIndex)
              }}
            >
              Filter
            </Button>
          </Space>
        </div>
      ),
      filterIcon: filtered => <SearchOutlined style={{ color: filtered ? '#1890ff' : undefined }} />,
      onFilter: (value, record) =>
        record[dataIndex]
          ? record[dataIndex].toString().toLowerCase().includes(value.toLowerCase())
          : '',
      onFilterDropdownVisibleChange: visible => {
        // if (visible) {
        //   setTimeout(() => this.searchInput.select(), 100);
        // }
      },
      render: text =>
        searchedColumn === dataIndex ? (
          <Highlighter
            highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
            searchWords={[searchText]}
            autoEscape
            textToHighlight={text ? text.toString() : ''}
          />
        ) : (
          text
        ),
    });
  
    const handleSearch = (selectedKeys, confirm, dataIndex) => {
      confirm();
        setSearchText(selectedKeys[0])
        setSearchedColumn(dataIndex)
    };
  
    const handleReset = clearFilters => {
      clearFilters();
      setSearchText('')
    };
    //Xử lý tìm kiếm (đóng)
    const contentStyle = {
        height: '160px',
        color: 'black',
        lineHeight: '160px',
        textAlign: 'center',
        background: '#364d79',
    };
    const columns = [
            {
              title: 'ID',
              dataIndex: 'id',
              key: 'id',
              sorter: (a, b) => a.id - b.id,
              sortDirections: ['descend'],
              ...getColumnSearchProps('id')
            },
            {
              title: 'Tiêu đề',
              dataIndex: 'tieude',
              key: 'tieude'
            },
            Table.EXPAND_COLUMN,
            {
              title: 'Địa chỉ',
              dataIndex: 'diachi',
              key: 'diachi',
              ...getColumnSearchProps('diachi')
            },
            {
              title: 'Giá',
              dataIndex: 'gia',
              key: 'gia',
              sorter: (a, b) => a.gia - b.gia,
              sortDirections: ['descend','ascend'],
              ...getColumnSearchProps('gia')
            },
            {
              title: 'Đơn vị',
              dataIndex: 'donvi',
              key: 'donvi'
            },
            {
              title: 'Người đăng',
              dataIndex: 'nguoidang',
              key: 'nguoidang',
              ...getColumnSearchProps('nguoidang')
            },
         {
            title: 'Ảnh',
            dataIndex: 'operation',
            render: (_, record) => {
                return (
                    <Popover 
                        content={
                            <Carousel autoplay autoplaySpeed={1000} style={{width: 200, height: 200}} >
                                <div>
                                    <img src={record.img1} style={{width: '100%', height: 200, contentStyle}}  />
                                </div>
                                <div>
                                    <img src={record.img2} style={{width: '100%', height: 200, contentStyle}}/>
                                </div>
                                <div>
                                    <img src={record.img3} style={{width: '100%', height: 200, contentStyle}}/>
                                </div>
                                <div>
                                    <img src={record.img4} style={{width: '100%', height: 200, contentStyle}}/>
                                </div>
                            </Carousel>
                        } 
                        title="Ảnh phòng trọ" 
                        trigger="click"
                    >
                        <Typography.Link>
                            <img src='https://pdp.edu.vn/wp-content/uploads/2021/05/hinh-anh-avatar-nam-1-600x600.jpg' width={50} height={40}/>
                        </Typography.Link>
                    </Popover>
                    
                )     
            }  
        },
        {
            title: 'Xử lý',
            dataIndex: 'operation',
            render: (_, record) => {
              return (
                <Popconfirm  title="Bạn chắc chắn xóa?" onConfirm={() => del(record.id)} >
                    <a><DeleteOutlined /></a>
                </Popconfirm> 
              )    
            }
        }
    ];
    
    const [pageSize, setPageSize] = useState(10)
    const [isCheckedAll, setIsCheckedAll] = useState({all: false, part: false, amount: 0})
    return (
        <>
            <Row>
                    <Col span={6} >
                        <h4 style={{ fontWeight: 'inherit', fontStyle: 'italic' }}>Có {dataSource.length} tin đã đăng</h4>
                    </Col>
                    <Col span={14}></Col>
                    <Col span={4}></Col>
            </Row>
            <Table
                pagination={{
                    onChange: (page, pageSize) => {
                        setPageSize(pageSize)
                    },
                    pageSizeOptions: [10,20,40,100],
                    showSizeChanger: true
                }}
                rowKey={record => record.id}
                columns={columns}
                expandable={{
                expandedRowRender: record => <p style={{ margin: 0 }}>{record.mota}</p>,
                }}
                dataSource={dataSource}
                style={{ marginTop: 9 }}
                // loading={loading}
            />
        </>
    )
}
export default Post