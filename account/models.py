# -*- coding: utf-8 -*-

import os
import json
from hashlib import md5
from core.dateutil import get_current_time_in_millis

from django.contrib.auth.signals import user_logged_in
from django.db import models
from django.contrib.auth.models import Group, User
from django.db.models import signals
from django.conf import settings
from django.db.models import F

from core import dateutil

MANAGER = 0
CUSTOMER = 1
AGENCY = 2
YUN_YING = 3
ROLES = (
	(MANAGER, u'管理员'),
	(CUSTOMER, u'合作客户'),
	(AGENCY, u'代理商'),
	(YUN_YING, u'运营')
)
ROLE2NAME = dict(ROLES)

#账号状态
STATUS_STOPED = 0
STATUS_RUNNING = 1
STATUS_NOT_IN_VALID_TIME = 2

#采购方式
METHOD = (
	(1, u'固定底价'),
	(2, u'零售价返点'),
	(3, u'以货抵款')
)
METHOD2NAME = dict(METHOD)

#===============================================================================
# UserProfile ： 用户信息
#===============================================================================

class UserProfile(models.Model):
	user = models.ForeignKey(User, unique=True)
	name = models.CharField(max_length=32) #账号名称
	manager_id = models.IntegerField(default=0) #创建该用户的系统用户的id
	role = models.IntegerField(default=MANAGER,choices=ROLES) #角色
	company_name = models.CharField(max_length=32, default='') #公司名称
	company_type = models.CharField(max_length=1024, default='') #经营类目(catalog表的id构成的list，例如[1,2])
	purchase_method = models.IntegerField(default=1) #采购方式
	points = models.FloatField(default=0) #零售价返点
	contacter = models.CharField(max_length=32, default='') #联系人
	phone = models.CharField(max_length=16, default='') #手机号
	valid_time_from = models.DateTimeField(null=True) #有效范围开始时间
	valid_time_to = models.DateTimeField(null=True) #有效范围结束时间
	note = models.CharField(max_length=1024, default='') #备注
	status = models.IntegerField(default=1) #账号状态 0停用中，1开启中，2不在有效期内
	is_active = models.BooleanField(default=True, verbose_name='用户是否有效') #是否删除
	created_at = models.DateTimeField(auto_now_add=True) #创建时间

	class Meta(object):
		db_table = 'account_user_profile'
		verbose_name = '用户配置'
		verbose_name_plural = '用户配置'

	@property
	def is_manager(self):
		return (self.user_id == self.manager_id) or (self.manager_id == 2) #2 is manager's id


def create_profile(instance, created, **kwargs):
	"""
	自动创建user profile
	"""
	if created:
		if instance.username == 'admin':
			return
		if UserProfile.objects.filter(user=instance).count() == 0:
			profile = UserProfile.objects.create(user = instance)
			

signals.post_save.connect(create_profile, sender=User, dispatch_uid = "account.create_profile")


class AccountHasSupplier(models.Model):
	user_id = models.IntegerField(default=0) #对应自营平台user_id
	account_id = models.IntegerField(default=0) #UserProfile id
	supplier_id = models.IntegerField(default=0) # 云上通的供货商id
	store_name = models.CharField(max_length=1024, default='') # y供货商名称

	class Meta(object):
		db_table = 'account_has_supplier'