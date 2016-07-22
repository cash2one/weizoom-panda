/**
 * Copyright(c) 2012-2016 weizoom
 */
"use strict";

var debug = require('debug')('m:product.product_relation:ProductRelationPage');
var React = require('react');
var ReactDOM = require('react-dom');
var _ = require('underscore');
var Reactman = require('reactman');

var Store = require('./Store');
var Constant = require('./Constant');
var Action = require('./Action');

var ProductRelationPage = React.createClass({

	getInitialState: function() {
		Store.addListener(this.onChangeStore);
		return ({});
	},

	onChangeStore: function(event) {
		var _this = this;
		var filterOptions = Store.getFilter();
		this.refs.table.refresh(filterOptions);
	},

	cancleChecked: function(product_id,self_name){
		console.log(product_id,self_name,"======");
		Action.cancleChecked(product_id,self_name);
	},

	productRelation: function(self_user_name,product_info) {
		var product_id = product_info['product_id']
		var obj = document.getElementById(product_id);
		obj = obj.getElementsByTagName('input');
		var check_val = [];
		for(var k=0;k<=obj.length-1;k++){
			var has_relation = true;
			if(obj[k]['checked']){
				// for(var index in self_user_name){
				// 	if (self_user_name[index] == obj[k].value){
				// 		has_relation = false;
				// 	}
				// }
				// if(has_relation){
				// 	check_val.push(obj[k].value);
				// }
				check_val.push(obj[k].value);
			}
		}
		console.log(check_val,"=========");
		if (check_val.length==0){
			Reactman.PageAction.showHint('error', '请选择要同步的商城！');
			return;
		}
		var product_data = [{
			'weizoom_self': check_val.join(','),//选择的商城
			'product_id': product_id,//商品id
			'account_id': product_info['account_id'], //所属账号 id
			'product_price': product_info['product_price'],
			'product_name': product_info['product_name'],//商品名称
			'clear_price': product_info['clear_price'],//商品结算价
			'product_weight': product_info['product_weight'],//商品重量
			'product_store': product_info['product_store'],//商品库存(-1:无限)
			'image_path': product_info['image_path'],//轮播图路径
			'promotion_title': product_info['promotion_title'],
			'detail': product_info['remark']//商品详情
		}]
		Action.relationFromWeapp(JSON.stringify(product_data));
	},

	rowFormatter: function(field, value, data) {
		if (field === 'weapp_name') {
			var id = data['id'];
			var self_user_name = data['self_user_name'];
			var w_b_checked = self_user_name.toString().indexOf('weizoom_baifumei')>-1?'checked':null;
			var w_c_checked = self_user_name.toString().indexOf('weizoom_club')>-1?'checked':null;
			var w_j_checked = self_user_name.toString().indexOf('weizoom_jia')>-1?'checked':null;
			var w_m_checked = self_user_name.toString().indexOf('weizoom_mama')>-1?'checked':null;
			var w_s_checked = self_user_name.toString().indexOf('weizoom_shop')>-1?'checked':null;
			var w_x_checked = self_user_name.toString().indexOf('weizoom_xuesheng')>-1?'checked':null;
			// var w_b_disabled = self_user_name.toString().indexOf('weizoom_baifumei')>-1?'disabled':'';
			// var w_c_disabled = self_user_name.toString().indexOf('weizoom_club')>-1?'disabled':'';
			// var w_j_disabled = self_user_name.toString().indexOf('weizoom_jia')>-1?'disabled':'';
			// var w_m_disabled = self_user_name.toString().indexOf('weizoom_mama')>-1?'disabled':'';
			// var w_s_disabled = self_user_name.toString().indexOf('weizoom_shop')>-1?'disabled':'';
			// var w_x_disabled = self_user_name.toString().indexOf('weizoom_xuesheng')>-1?'disabled':'';
			var cancleChecked = function(){

			}
			return (
				<div id={id}>
					<label className="checkbox-inline" style={{marginRight:'15px',marginLeft:'10px',width:'90px'}}>
						<input type="checkbox" checked={w_b_checked} className="checkbox" name="weizoom_self" value="weizoom_baifumei" onChange={this.cancleChecked.bind(this,id,'weizoom_baifumei')} />
						<span>微众白富美</span>
					</label>
					<label className="checkbox-inline" style={{marginRight:'15px',width:'90px'}}>
						<input type="checkbox" checked={w_c_checked} className="checkbox" name="weizoom_self" value="weizoom_club" onChange={this.cancleChecked.bind(this,id,'weizoom_club')} />
						<span>微众俱乐部</span>
					</label>
					<label className="checkbox-inline" style={{marginRight:'15px',width:'90px'}}>
						<input type="checkbox" checked={w_j_checked} className="checkbox" name="weizoom_self" value="weizoom_jia" onChange={this.cancleChecked.bind(this,id,'weizoom_jia')} />
						<span>微众家</span>
					</label>
					<label className="checkbox-inline" style={{marginRight:'15px',width:'90px'}}>
						<input type="checkbox" checked={w_m_checked} className="checkbox" name="weizoom_self" value="weizoom_mama" onChange={this.cancleChecked.bind(this,id,'weizoom_mama')} />
						<span>微众妈妈</span>
					</label>
					<label className="checkbox-inline" style={{marginRight:'15px',width:'90px'}}>
						<input type="checkbox" checked={w_s_checked} className="checkbox" name="weizoom_self" value="weizoom_shop" onChange={this.cancleChecked.bind(this,id,'weizoom_shop')} />
						<span>微众商城</span>
					</label>
					<label className="checkbox-inline" style={{marginRight:'15px',width:'90px'}}>
						<input type="checkbox" checked={w_x_checked} className="checkbox" name="weizoom_self" value="weizoom_xuesheng" onChange={this.cancleChecked.bind(this,id,'weizoom_xuesheng')} />
						<span>微众学生</span>
					</label>
					<a className="btn btn-link btn-xs" style={{color:'#1ab394'}} onClick={this.productRelation.bind(this,data['self_user_name'],data['product_info'])}>同步</a>
				</div>
			);
		}else if(field === 'product_name'){
			return(
				<a className="btn btn-link btn-xs" href={'/product/new_product/?id='+data.id}>{value}</a>
			)
		} else {
			return value;
		}
	},

	onConfirmFilter: function(data){
		Action.filterDates(data);
	},

	render:function(){
		var productsResource = {
			resource: 'product.product_relation',
			data: {
				page: 1
			}
		};

		return (
			<div className="mt15 xui-product-productListPage">
				<Reactman.FilterPanel onConfirm={this.onConfirmFilter}>
					<Reactman.FilterRow>
						<Reactman.FilterField>
							<Reactman.FormInput label="客户名称:" name="customer_name_query" match='=' />
						</Reactman.FilterField>
						<Reactman.FilterField>
							<Reactman.FormInput label="商品名称:" name="product_name_query" match="=" />
						</Reactman.FilterField>
					</Reactman.FilterRow>
				</Reactman.FilterPanel>
				<Reactman.TablePanel>
					<Reactman.TableActionBar></Reactman.TableActionBar>
					<Reactman.Table resource={productsResource} formatter={this.rowFormatter} pagination={true} expandRow={true} ref="table">
						<Reactman.TableColumn name="商品名称" field="product_name" />
						<Reactman.TableColumn name="客户名称" field="customer_name" />
						<Reactman.TableColumn name="总销量" field="total_sales" />
						<Reactman.TableColumn name="同步商品" field="weapp_name" width="440px"/>
					</Reactman.Table>
				</Reactman.TablePanel>
			</div>
		)
	}
})
module.exports = ProductRelationPage;