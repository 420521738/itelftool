#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django import forms
from django.forms.widgets import *
from broken_record.models import BrokenRrecord, Developer


class DeveloperForm(forms.ModelForm):

    class Meta:
        model = Developer
        exclude = ("id",)
        widgets = {
            'name': TextInput(attrs={'class': 'form-control','style': 'width:450px;'}),
            'phone': TextInput(attrs={'class': 'form-control','style': 'width:450px'}),
            'qq': TextInput(attrs={'class': 'form-control','style': 'width:450px;'}),
            'weChat': TextInput(attrs={'class': 'form-control','style': 'width:450px;'}),
        }

class BrokenRrecordForm(forms.ModelForm):

    class Meta:
        model = BrokenRrecord
        exclude = ("id",)

        widgets = {
            'name': TextInput(attrs={'class': 'form-control','style': 'width:450px;'}),
            'description': Textarea(attrs={'class': 'form-control','style': 'width:450px; height:100px'}),
            'broken_type': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            'severity_type': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            'broken_status_type': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            #'broken_department': forms.SelectMultiple(attrs={'class': 'form-control', 'size':'10', 'multiple': 'multiple'}),
            'broken_department': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            'occur_time': forms.DateTimeInput(attrs={'class': 'form-control', 'style': 'width:450px;', 'placeholder': u'2018-09-01 11:11:11'}),
            'end_time': forms.DateTimeInput(attrs={'class': 'form-control', 'style': 'width:450px;', 'placeholder': u'2018-09-01 12:12:12'}),
            'business_impact_time': TextInput(attrs={'class': 'form-control','style': 'width:450px;'}),
            'process_description': Textarea(attrs={'class': 'form-control','style': 'width:450px; height:100px'}),
            'precaution': Textarea(attrs={'class': 'form-control','style': 'width:450px; height:100px'}),
            #'maintenance': forms.SelectMultiple(attrs={'class': 'form-control', 'size':'10', 'multiple': 'multiple'}),
            'maintenance': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            #'developer': forms.SelectMultiple(attrs={'class': 'form-control', 'size':'10', 'multiple': 'multiple'}),
            'developer': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            'product': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            'project': Select(attrs={'class': 'form-control','style': 'width:450px;'}),
            #'update_date': forms.DateTimeInput(attrs={'class': 'form-control', 'style': 'width:450px;'}),
        }
