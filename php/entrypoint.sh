#!/bin/bash

set -e

cron
supervisord

exec "$@"
