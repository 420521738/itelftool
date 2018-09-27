#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render, HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from accounts.permission import permission_verify
from setup.models import TaskRecord


@login_required()
@permission_verify()
def record_list(request):
    all_records = TaskRecord.objects.all().order_by('-tasktime')
    results = {
        'all_records': all_records,
    }
    return render(request, 'setup/records_list.html', results)



def record_export(request):
    pass