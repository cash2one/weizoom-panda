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
		'handleUpdateAccount': Constant.NEW_ACCOUNT_UPDATE_ACCOUNT,
		'handleCreateNewAccount': Constant.NEW_ACCOUNT_CREATE,
		'handleUpdateCatalog': Constant.UPDATE_CATALOG,
		'handleSelect': Constant.SELECT_CATALOG,
		'handleGetQualifications': Constant.GET_QUALIFICATIONS
	},

	init: function() {
		this.data = Reactman.loadJSON('business_data');
		this.data['company_type'] = String(this.data['company_type']);
		this.data['options_for_type'] = [];
	},

	handleSelect: function(action) {
		this.data['options_for_type'] = action.data.rows;
		this.__emitChange();
	},

	handleGetQualifications: function(action) {
		this.data['uploadBusinessQualifications'] = action.data.rows;
		this.__emitChange();
	},
	
	handleUpdateAccount: function(action) {
		this.data[action.data.property] = action.data.value;
		this.__emitChange();
	},

	handleCreateNewAccount: function(action) {
		W.gotoPage('/business/manager/');
	},

	handleUpdateCatalog: function(action) {
		var old_model = action.data.model;
		old_model[action.data.property] = action.data.value;
		this.__emitChange();
	},

	getData: function() {
		return this.data;
	}
});

module.exports = Store;