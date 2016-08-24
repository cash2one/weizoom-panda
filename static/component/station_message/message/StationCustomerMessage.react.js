/**
 * Copyright(c) 2012-2016 weizoom
 */
"use strict";
var React = require('react');
var ReactDOM = require('react-dom');

var Reactman = require('reactman');
var W = Reactman.W;

var Store = require('./Store');
var Constant = require('./Constant');
var Action = require('./Action');
require('./style.css');

var AddSelfShopDialog = React.createClass({
	getInitialState: function() {
		Store.addListener(this.onChangeStore);
		return Store.getData();
	},

	onChange: function(value, event) {
		var property = event.target.getAttribute('name');
		Action.updateMessage(property, value);
	},

	onChangeStore: function(){
		this.setState(Store.getData());
	},

	render:function(){
	    var remark = this.state.text;
		var converter = document.createElement("DIV");
		converter.innerHTML = remark;
        var output = converter.innerText;
        var attachments = this.state.attachments;
        var at_url = attachments.map(function(attachment, index){
            return (
                <a href={attachment.path} download>{attachment.filename}</a>
            );
        });
		return (
		    <div className="xui-formPage ">
                <div className="title">
                    <span >商品详情</span>
                </div>
                <div className="time">
                    <span >2016-03-03 09:09:09</span>
                </div>
                <div className='text' >
                    <div className="" dangerouslySetInnerHTML={{__html: output}}></div>
                </div>
                <div className='attachment' >
                    附件:{at_url}
                </div>
            </div>

		)
	}
})
module.exports = AddSelfShopDialog;