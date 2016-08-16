/**
 * Copyright(c) 2012-2016 weizoom
 */
"use strict";

var debug = require('debug')('m:outline.datas:Store');
var EventEmitter = require('events').EventEmitter;
var assign = require('object-assign');
var _ = require('underscore');

var Reactman = require('reactman');
var Dispatcher = Reactman.Dispatcher;
var StoreUtil = Reactman.StoreUtil;

var Constant = require('./Constant');

var Store = StoreUtil.createStore(Dispatcher, {
	actions: {
		'handleProductRelationWeapp': Constant.PRODUCT_RELATION_WEAPP,
		'handleProductRelationDataFilter': Constant.PRODUCT_RELATION_DATAS_FILTER,
		'handleDeleteProductRelationWeapp': Constant.DELETE_PRODUCT_RELATION_WEAPP,
		'handleChooseSelfShop': Constant.CHOOSE_SELF_SHOP,
		'handleGetHasSyncShop': Constant.GET_HAS_SYNC_SHOP,
		'handleChooseAllSelfShop': Constant.CHOOSE_ALL_SELF_SHOP,
		'handleCancleSelectSyncProduct': Constant.CANCLE_SELECT_SYNC_PRODUCT
	},

	init: function() {
		this.filter = {};
		this.data = {
			'selectSelfShop': [],
			'product_info': {}
		};
	},

	handleProductRelationWeapp: function(action) {
		if(action.data['code']==200){
			setTimeout(function() {
			 	Reactman.PageAction.showHint('success', action.data.errMsg);
			}, 10);
		}else{
			setTimeout(function() {
			 	Reactman.PageAction.showHint('error', action.data.errMsg);
			}, 10);
		}

		this.__emitChange();
	},

	handleProductRelationDataFilter: function(action){
		this.filter = action.data;
		this.__emitChange();
	},

	handleDeleteProductRelationWeapp: function(action){
		setTimeout(function() {
		 	Reactman.PageAction.showHint('success', '取消成功');
		}, 10);
		this.__emitChange();
	},

	handleChooseSelfShop: function(action){
		var selectSelfShop = this.data.selectSelfShop;
		var value = action.data.value;
		var isChoosed = true;

		for(var index in selectSelfShop){
			if(selectSelfShop[index]==value){
				isChoosed = false;
				selectSelfShop.splice(index,1);
			}
		}

		if(isChoosed){
			selectSelfShop.push(value);
		}

		this.data.selectSelfShop = selectSelfShop;
		this.__emitChange();
	},

	handleGetHasSyncShop: function(action){
		// this.data['product_info'] = action.data.product_info;
		this.data['selectSelfShop'] = action.data.self_user_name;
		this.__emitChange();
	},

	handleChooseAllSelfShop: function(action){
		var selectSelfShop = this.data.selectSelfShop;

		if(selectSelfShop.length==17){
			selectSelfShop = [];
		}else{
			selectSelfShop = ['weizoom_baifumei','weizoom_club','weizoom_jia','weizoom_mama','weizoom_shop','weizoom_xuesheng',
			'weizoom_life','weizoom_yjr','weizoom_fulilaile','weizoom_juweihui','weizoom_zhonghai','weizoom_zoomjulebu','weizoom_chh',
			'weizoom_pengyouquan','weizoom_shxd','weizoom_jinmeihui','weizoom_wzbld'];
		}

		this.data.selectSelfShop = selectSelfShop;
		this.__emitChange();
	},

	handleCancleSelectSyncProduct: function(){
		this.data.selectSelfShop = [];
		this.__emitChange();
	},

	getData: function() {
		return this.data;
	},

	getFilter: function() {
		return this.filter;
	}
});

module.exports = Store;