/**
 * Copyright(c) 2012-2016 weizoom
 */
"use strict";

var debug = require('debug')('m:order.customer_order_detail:OrderDataPage');
var React = require('react');
var ReactDOM = require('react-dom');

var Reactman = require('reactman');
var Dispatcher = Reactman.Dispatcher;
var Resource = Reactman.Resource;

var Store = require('./Store');
var Action = require('./Action');
require('./style.css')

var OrderLogistics = React.createClass({
	render:function(){
		var options = {
			'':'',
			'shentong': '申通快递',
			'ems': 'EMS',
			'yuantong': '圆通速递',
			'shunfeng': '顺丰速运',
			'zhongtong': '中通速递',
			'tiantian': '天天快递',
			'yunda': '韵达快运',
			'huitongkuaidi': '百世快递',
			'quanfengkuaidi': '全峰快递',
			'debangwuliu': '德邦物流',
			'zhaijisong': '宅急送',
			'kuaijiesudi': '快捷速递',
			'bpost': '比利时邮政',
			'suer': '速尔快递',
			'guotongkuaidi': '国通快递',
			'youzhengguonei': '邮政包裹/平邮',
			'rufengda': '如风达',
			'youshuwuliu': '优速物流',
			'annengwuliu': '安能物流',
			'yuanchengkuaiyun':'远成快运'
		};
		var orde_datas = this.props.ordeDatas;
		var ship_name = orde_datas['ship_name']?orde_datas['ship_name']:'';
		var ship_tel = orde_datas['ship_tel']?orde_datas['ship_tel']:'';
		var customer_message = orde_datas['customer_message']?orde_datas['customer_message']:'';
		var ship_address = orde_datas['ship_address']?orde_datas['ship_address']:'';
		var ship_area = orde_datas['ship_area']?orde_datas['ship_area']:'';
		var express_company_name = orde_datas['express_company_name']?orde_datas['express_company_name']:'';
		var express_number = orde_datas['express_number']?orde_datas['express_number']:'';
		var order_status = orde_datas['order_status']?orde_datas['order_status']:'';
		var order_express_details = orde_datas['order_express_details']?orde_datas['order_express_details']:'';
		express_company_name = options.hasOwnProperty(express_company_name)?options[express_company_name]:express_company_name;
		var order_express = '';
		if(order_express_details.length>0){
			order_express = JSON.parse(order_express_details).map(function(order_expres,index){
				return(
					<div key={index}>
						<span>{order_expres['ftime']} {order_expres['context']}</span>
					</div>
				)
			})
		}
		if(order_status=='已发货' && express_number.length==0){
			express_company_name = express_number = '无需物流';
		}
		return (
			<div style={{marginTop:'10px',fontSize:'16px',background:'#FFF',border:'1px solid #CCC'}}>
				<div style={{padding:'5px 20px'}}>
					<div style={{marginTop:'5px'}}>
						<span className="inline-block">收货人:{ship_name}</span>
						<span className="inline-block" style={{marginLeft:'130px'}}>收货人电话:{ship_tel}</span>
					</div>
					<div style={{marginTop:'5px'}}>
						<span>收货地址:{ship_area},{ship_address}</span>
					</div>
					<div style={{borderBottom: '1px solid #ECE9E9',marginTop:'5px'}}>
						<span>买家留言:{customer_message}</span>
					</div>
				</div>
				<div style={{padding:'5px 20px'}}>
					<div style={{marginTop:'5px'}}>
						<span>物流公司名称:{express_company_name}</span>
					</div>
					<div style={{marginBottom: '20px',marginTop:'5px'}}>
						<span>运单号:{express_number}</span>
					</div>
					<div>
						{order_express}
					</div>
				</div>
			</div>
		)
	}
})
module.exports = OrderLogistics;