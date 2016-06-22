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
var ProductRelationDialog = require('./ProductRelationDialog.react');

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

	productRelation: function(self_shop,product_id) {
		Action.getWeappProductRelation(product_id);
		Reactman.PageAction.showDialog({
			title: "编辑云商通商品ID",
			component: ProductRelationDialog,
			data: {
				self_shop: JSON.parse(self_shop),
				product_id: product_id
			},
			success: function(inputData, dialogState) {
				console.log("success");
			}
		});
		// var obj = document.getElementById(product_id);
		// obj = obj.getElementsByTagName('input');
		// var check_val = [];
		// for(var k=0;k<=obj.length-1;k++){
		// 	if(obj[k]['checked']){
		// 		check_val.push(obj[k].value);
		// 	}
		// }

		// console.log(check_val,"--------");
		// console.log(check_val.join(','),"--------");
	},

	rowFormatter: function(field, value, data) {
		if (field === 'weapp_name') {
			var relations = data['relations'];
			var id = data['id'];
			console.log(data['self_user_name'],"=====");
			if(relations){
				relations = JSON.parse(relations).map(function(relation,index){
					return(
						<div style={{display:'inline-block'}} key={index}>
							<span style={{display:'inline-block', marginRight:'20px'}}>{relation['self_first_name']}:{relation['weapp_product_id']}</span>
						</div>
					)
				});
			}
			// var self_user_name = data['self_user_name'];
			// var w_b_checked = self_user_name.toString().indexOf('weizoom_baifumei')>-1?'checked':null;
			// var w_j_checked = self_user_name.toString().indexOf('weizoom_jia')>-1?'checked':null;
			// var w_m_checked = self_user_name.toString().indexOf('weizoom_mama')>-1?'checked':null;
			// var w_s_checked = self_user_name.toString().indexOf('weizoom_shop')>-1?'checked':null;
			// var w_x_checked = self_user_name.toString().indexOf('weizoom_xuesheng')>-1?'checked':null;
			// var w_b_disabled = self_user_name.toString().indexOf('weizoom_baifumei')>-1?'disabled':'';
			// var w_j_disabled = self_user_name.toString().indexOf('weizoom_jia')>-1?'disabled':'';
			// var w_m_disabled = self_user_name.toString().indexOf('weizoom_mama')>-1?'disabled':'';
			// var w_s_disabled = self_user_name.toString().indexOf('weizoom_shop')>-1?'disabled':'';
			// var w_x_disabled = self_user_name.toString().indexOf('weizoom_xuesheng')>-1?'disabled':'';
			// return (
			// 	<div id={id}>
			// 		<label className="checkbox-inline" style={{marginRight:'15px',marginLeft:'10px'}}>
			// 			<input type="checkbox" disabled={w_b_disabled} checked={w_b_checked} className="checkbox" name="weizoom_self" value="weizoom_baifumei"/>
			// 			<span>微众白富美</span>
			// 		</label>
			// 		<label className="checkbox-inline" style={{marginRight:'15px'}}>
			// 			<input type="checkbox" disabled={w_j_disabled} checked={w_j_checked} className="checkbox" name="weizoom_self" value="weizoom_jia"/>
			// 			<span>微众家</span>
			// 		</label>
			// 		<label className="checkbox-inline" style={{marginRight:'15px'}}>
			// 			<input type="checkbox" disabled={w_m_disabled} checked={w_m_checked} className="checkbox" name="weizoom_self" value="weizoom_mama"/>
			// 			<span>微众妈妈</span>
			// 		</label>
			// 		<label className="checkbox-inline" style={{marginRight:'15px'}}>
			// 			<input type="checkbox" disabled={w_s_disabled} checked={w_s_checked} className="checkbox" name="weizoom_self" value="weizoom_shop"/>
			// 			<span>微众商城</span>
			// 		</label>
			// 		<label className="checkbox-inline" style={{marginRight:'15px'}}>
			// 			<input type="checkbox" disabled={w_x_disabled} checked={w_x_checked} className="checkbox" name="weizoom_self" value="weizoom_xuesheng"/>
			// 			<span>微众学生</span>
			// 		</label>
			// 		<a className="btn btn-link btn-xs" style={{color:'#1ab394'}} onClick={this.productRelation.bind(this,data['self_shop'],data['id'])}>同步</a>
			// 	</div>
			// );
			return(
				<div>
					{relations}
					<a className="btn btn-link btn-xs" style={{color:'#1ab394'}} onClick={this.productRelation.bind(this,data['self_shop'],data['id'])}>编辑</a>
				</div>
			)
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
						<Reactman.FilterField>
							<Reactman.FormInput label="云商通商品ID:" name="weapp_name_query" match="=" />
						</Reactman.FilterField>
					</Reactman.FilterRow>
				</Reactman.FilterPanel>
				<Reactman.TablePanel>
					<Reactman.TableActionBar></Reactman.TableActionBar>
					<Reactman.Table resource={productsResource} formatter={this.rowFormatter} pagination={true} expandRow={true} ref="table">
						<Reactman.TableColumn name="商品名称" field="product_name" />
						<Reactman.TableColumn name="客户名称" field="customer_name" />
						<Reactman.TableColumn name="总销量" field="total_sales" />
						<Reactman.TableColumn name="云商通商品ID" field="weapp_name" width="640px"/>
					</Reactman.Table>
				</Reactman.TablePanel>
			</div>
		)
	}
})
module.exports = ProductRelationPage;