#!/bin/bash
#GHA2DB_LOCAL=1 GHA2DB_SKIPPDB=1 GHA2DB_RECENT_RANGE="2 days" GHA2DB_ONLY_ISSUES="269064129,308780535" GHA2DB_ONLY_EVENTS="281482416728565,281482416827759,281482416872593" GHA2DB_DEBUG=1 GHA2DB_QOUT=1 ./ghapi2db
GHA2DB_LOCAL=1 GHA2DB_SKIPPDB=1 GHA2DB_RECENT_RANGE="3 hour" GHA2DB_RECENT_REPOS_RANGE="3 hour" PG_DB=gha ./ghapi2db
