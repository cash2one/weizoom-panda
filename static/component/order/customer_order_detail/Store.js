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
		'handleSaveProduct': Constant.ORDER_DATA_SAVE_PRODUCT
	},

	init: function() {
		this.data = {};

		var orderDatas = Reactman.loadJSON('orderDatas');
		if(orderDatas){
			this.data = orderDatas['orders'][0];
		}
	},

	handleSaveProduct: function(action) {
		this.data = action.data.rows[0];
		this.__emitChange();
	},

	getData: function() {
		return this.data;
	}
});

module.exports = Store;