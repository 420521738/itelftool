#! /usr/bin/env python
# -*- coding: utf-8 -*-

from django.shortcuts import render, HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from broken_record.models import BrokenRrecord
from broken_record.forms import BrokenRrecordForm
from django.core.urlresolvers import reverse

@login_required
def brokenrecord_list(request):
    all_brokenrecord = BrokenRrecord.objects.all()
    results = {
        'all_brokenrecord':  all_brokenrecord,
    }
    return render(request, 'broken_record/broken_record_list.html', results)


@login_required
def brokenrecord_add(request):
    if request.method == 'POST':
        form = BrokenRrecordForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('brokenrecord'))
    else:
        form = BrokenRrecordForm()

    results = {
        'form': form,
        'request': request,
    }
    return render(request, 'broken_record/brokenrecord_base.html', results)


@login_required
def brokenrecord_edit(request, brokenrecord_id):
    brokenrecord = BrokenRrecord.objects.get(id=brokenrecord_id)
    if request.method == 'POST':
        form = BrokenRrecordForm(request.POST, instance=brokenrecord)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('brokenrecord'))
    else:
        form = BrokenRrecordForm(instance=brokenrecord)

    results = {
        'form': form,
        'brokenrecord_id': brokenrecord_id,
        'request': request,
    }
    return render(request, 'broken_record/brokenrecord_base.html', results)


@login_required
def brokenrecord_del(request):
    brokenrecord_id = request.GET.get('id', '')
    if brokenrecord_id:
        BrokenRrecord.objects.filter(id=brokenrecord_id).delete()

    brokenrecord_id_all = str(request.POST.get('brokenrecord_id_all', ''))
    if brokenrecord_id_all:
        for brokenrecord_id in brokenrecord_id_all.split(','):
            BrokenRrecord.objects.filter(id=brokenrecord_id).delete()

    return HttpResponseRedirect(reverse('brokenrecord'))