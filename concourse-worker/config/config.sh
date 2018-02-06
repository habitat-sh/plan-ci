#!/bin/bash

{{#if bind.web ~}}
{{#with bind.web.first as |web| }}
export CONCOURSE_TSA_HOST="{{web.sys.ip}}"
{{/with}}
{{else ~}}
export CONCOURSE_TSA_HOST="localhost"
{{/if ~}}