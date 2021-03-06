/**
 * Copyright(c) 2012-2016 weizoom
 */
"use strict";

var debug = require('debug')('m:order.customer_orders_list:ShipDialog');
var React = require('react');
var ReactDOM = require('react-dom');

var Reactman = require('reactman');

var Store = require('./DialogStore');
var Constant = require('./Constant');
var Action = require('./Action');

var ShipDialog = Reactman.createDialog({
	getInitialState: function() {
		Store.addListener(this.onChangeStore);
		var order_id = this.props.data.order_id;
		if(this.props.data.express_company_name){
			var ship_company = this.props.data.express_company_name;
		}else{
			var ship_company = '-1';
		}
		var ship_companyr_name = this.props.data.express_company_storename;
		var ship_number = this.props.data.express_number;
		var shiper_name = this.props.data.leader_name;
		var isNeedShip = this.props.data.is_need_ship;
		var __method = this.props.data.__method;
		return {
			order_id: order_id,
			ship_company: ship_company,
			ship_companyr_name: ship_companyr_name,
			ship_number: ship_number,
			shiper_name: shiper_name,
			__method: __method,
			is_need_ship: isNeedShip
		}
	},

	onChange: function(value, event) {
		var property = event.target.getAttribute('name');
		var newState = {};
		if(property == 'ship_companyr_name'){
			newState['ship_company'] = 'qita'
		}
		newState[property] = value;
		this.setState(newState);
	},

	onChangeStore: function(){
		var infomations = Store.getData();
		this.setState({
			ship_company: infomations['ship_company'],
			ship_number: infomations['ship_number'],
			shiper_name: infomations['shiper_name'],
			is_need_ship: infomations['is_need_ship']
		})
	},

	onBeforeCloseDialog: function() {
		if (this.state.is_need_ship=='1' && this.state.ship_company === '-1') {
			Reactman.PageAction.showHint('error', '请选择物流公司');
		} else {
			//给接口传递发货信息的参数
			if (this.state.ship_company =='qita'){
				var shipCompany = this.state.ship_companyr_name;
			}else{
				var shipCompany = this.state.ship_company;
			}
			
			var shipNumber = this.state.ship_number;
			if(this.state.is_need_ship=='0'){
				shipCompany = '';
				shipNumber = '';
			}
			Reactman.Resource.put({
				resource: 'order.order_ship_informations',
				data: {
					order_id: this.state.order_id,
					express_company_name: shipCompany,
					express_number: shipNumber,
					leader_name: this.state.shiper_name,
					__method: this.state.__method
				},
				success: function() {
					if(this.state.__method == 'post'){
						_.delay(function() {
							Reactman.PageAction.showHint('success', '修改物流信息成功');
						}, 500);
					}else{
						_.delay(function() {
							Reactman.PageAction.showHint('success', '发货成功');
						}, 500);
					}
					this.closeDialog();
				},
				error: function(data) {
					Reactman.PageAction.showHint('error', data.errMsg);
				},
				scope: this
			})
		}
	},

	render:function(){
		var optionsForShip = [{
			text: '需要物流', value: '1'
		}, {
			text: '不需要物流', value: '0'
		}];
		return (
		<div className="xui-formPage">
			<form className="form-horizontal mt15">
				<fieldset>
					<Reactman.FormRadio label="发货方式:" type="text" name="is_need_ship" value={this.state.is_need_ship} options={optionsForShip} onChange={this.onChange} />
					<div><ShipInfo onChange={this.onChange} isNeedShip={this.state.is_need_ship} shiperName={this.state.shiper_name} shipNumber={this.state.ship_number} shipCompany={this.state.ship_company} shipCompanyrName={this.state.ship_companyr_name}/> </div>
				</fieldset>
			</form>
		</div>
		)
	}
})

var ShipInfo = Reactman.createDialog({
	render: function(){
		var options = [{
			text: '请选择物流公司',
			value: '-1'
		}, {
			text: '申通快递',
			value: 'shentong'
		},{
			text: 'EMS',
			value: 'ems'
		},{
			text: '顺丰速运',
			value: 'shunfeng'
		},{
			text: '圆通速递',
			value: 'yuantong'
		},{
			text: '中通速递',
			value: 'zhongtong'
		},{
			text: '天天快递',
			value: 'tiantian'
		},{
			text: '韵达快运',
			value: 'yunda'
		},{
			text: '百世快递',
			value: 'huitongkuaidi'
		},{
			text: '全峰快递',
			value: 'quanfengkuaidi'
		},{
			text: '德邦物流',
			value: 'debangwuliu'
		},{
			text: '宅急送',
			value: 'zhaijisong'
		},{
			text: '快捷速递',
			value: 'kuaijiesudi'
		},{
			text: '比利时邮政',
			value: 'bpost'
		},{
			text: '速尔快递',
			value: 'suer'
		},{
			text: '国通快递',
			value: 'guotongkuaidi'
		},{
			text: '如风达',
			value: 'rufengda'
		},{
			text: '邮政包裹/平邮',
			value: 'youzhengguonei'
		},{
			text: '优速物流',
			value: 'youshuwuliu'
		},{
			text: '安能物流',
			value: 'annengwuliu'
		},{
			text: '远成快运',
			value: 'yuanchengkuaiyun'
		},{
			text: '其他',
			value: 'qita'
		}];
		var isNeedShip = this.props.isNeedShip;
		if(isNeedShip=='0'){
			return(
				<div>
					<Reactman.FormInput label="发货人:" name="shiper_name" placeholder="备注请用竖线隔开" value={this.props.shiperName} onChange={this.props.onChange} />
				</div>
			)
		}else{
			var qitaNodebody = this.props.shipCompany == 'qita'? <Reactman.FormInput label="物流公司名称:" name="ship_companyr_name" validate="require-string" value={this.props.shipCompanyrName} onChange={this.props.onChange} /> : ''
			var waringNodebody = this.props.shipCompany == 'qita'? <div style={{padding:'10px 180px', color:'rgba(138, 43, 43, 0.82)', marginTop:'-15px'}}>提示：不能跟踪物流信息,且需手动完成订单</div> : ''
			return(
				<div>
					<Reactman.FormSelect label="物流公司:" name="ship_company" validate="require-notempty" value={this.props.shipCompany} options={options} onChange={this.props.onChange}/>
					{qitaNodebody}
					{waringNodebody}
					<Reactman.FormInput label="快递单号:" name="ship_number" validate="require-string" value={this.props.shipNumber} onChange={this.props.onChange} />
					<Reactman.FormInput label="发货人:" name="shiper_name" placeholder="备注请用竖线隔开" value={this.props.shiperName} onChange={this.props.onChange} />
				</div>
			)
		}
	}
})
module.exports = ShipDialog;