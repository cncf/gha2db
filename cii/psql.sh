#!/bin/bash
set -o pipefail
function finish {
    sync_unlock.sh
}
if [ -z "$TRAP" ]
then
  sync_lock.sh || exit -1
  trap finish EXIT
  export TRAP=1
fi
> errors.txt
> run.log
GHA2DB_PROJECT=cii PG_DB=cii GHA2DB_LOCAL=1 structure 2>>errors.txt | tee -a run.log || exit 1
./devel/db.sh psql cii -c "create extension if not exists pgcrypto" || exit 1
GHA2DB_PROJECT=cii PG_DB=cii GHA2DB_LOCAL=1 gha2db 2015-01-01 0 today now 'BendingBender/object-assign-shim,DataTables/DataTables,FasterXML/jackson-annotations,FasterXML/jackson-core,FasterXML/jackson-databind,FortAwesome/Font-Awesome,Gozala/querystring,JamesNK/Newtonsoft.Json,JedWatson/classnames,JohnPostlethwait/stringify,Modernizr/Modernizr,OverZealous/run-sequence,Raynos/xtend,ReactTraining/react-router,acornjs/acorn,ahmadnassri/node-har-validator,angular-translate/angular-translate,angular-ui/ui-router,angular/angular,angular/angular.js,angular/animations-builds,angular/cdk-builds,angular/common-builds,angular/core-builds,angular/forms-builds,angular/http-builds,angular/platform-browser-builds,angular/platform-browser-dynamic-builds,angular/platform-server-builds,angular/zone.js,apache/commons-codec,apache/commons-collections,apache/commons-io,apache/commons-lang,apache/commons-logging,apache/httpcomponents-client,apache/log4j,ashtuchkin/iconv-lite,auth0/angular2-jwt,auth0/node-jsonwebtoken,axios/axios,beanvalidation/beanvalidation-api,beatgammit/base64-js,bestiejs/punycode.js,brix/crypto-js,broofa/node-mime,broofa/node-uuid,browserify/browserify,browserify/resolve,calvinmetcalf/process-nextick-args,caolan/async,chalk/ansi-regex,chalk/ansi-styles,chalk/chalk,chalk/strip-ansi,chalk/supports-color,davepacheco/node-extsprintf,davepacheco/node-verror,devongovett/browserify-istanbul,dotnet/corefx,dougwilson/nodejs-depd,eclipse-ee4j/jaxrs-api,eclipse-ee4j/servlet-api,epoberezkin/ajv,expressjs/body-parser,expressjs/compression,expressjs/cookie-parser,expressjs/cors,expressjs/express,expressjs/morgan,expressjs/serve-favicon,expressjs/session,facebook/prop-types,facebook/react,felixge/node-combined-stream,feross/is-buffer,feross/safe-buffer,form-data/form-data,google/gson,google/guava,google/guice,gotwarlost/istanbul,gulpjs/vinyl,hapijs/boom,hapijs/cryptiles,hapijs/hoek,hueniverse/hawk,hueniverse/sntp,hughsk/vinyl-buffer,hughsk/vinyl-source-stream,isaacs/abbrev-js,isaacs/inherits,isaacs/minimatch,isaacs/node-glob,isaacs/node-graceful-fs,isaacs/node-lru-cache,isaacs/node-which,isaacs/once,isaacs/rimraf,isaacs/sax-js,janvanhelvoort/browserify-conditionalify,jaredhanson/passport,jashkenas/underscore,jonschlinkert/arr-diff,jonschlinkert/define-property,jonschlinkert/fill-range,jonschlinkert/is-extendable,jonschlinkert/is-extglob,jonschlinkert/is-glob,jonschlinkert/is-number,jonschlinkert/isobject,jonschlinkert/kind-of,joyent/node-http-signature,joyent/node-jsprim,joyent/node-sshpk,jquery-validation/jquery-validation,jquery/esprima,jquery/jquery,jquery/jquery-ui,jshttp/accepts,jshttp/http-errors,jshttp/mime-db,jshttp/mime-types,jshttp/statuses,juliangruber/balanced-match,juliangruber/brace-expansion,juliangruber/isarray,kelektiv/node-uuid,kennethreitz/requests,ljharb/qs,lodash/lodash,madler/zlib,mafintosh/end-of-stream,maxogden/concat-stream,mcavage/node-assert-plus,mde/ejs,micromatch/braces,micromatch/micromatch,mikeal/caseless,mikeal/oauth-sign,mikeal/tunnel-agent,moment/moment,moment/moment-timezone,motdotla/dotenv,moxystudio/node-cross-spawn,mozilla/source-map,mysql-net/MySqlConnector,nanjingboy/uglify,necolas/normalize.css,ng-bootstrap/ng-bootstrap,nodejs/readable-stream,nodejs/string_decoder,npm/node-semver,npm/nopt,nunit/nunit,omsmith/browserify-ngannotate,openssl/openssl,petkaantonov/bluebird,pieroxy/lz-string,pillarjs/finalhandler,pillarjs/send,pvorb/node-clone,qos-ch/logback,qos-ch/slf4j,que-etc/resize-observer-polyfill,reactivex/rxjs,reduxjs/react-redux,reduxjs/redux,reduxjs/redux-thunk,request/request,request/request-promise,robrich/orchestrator,robrich/pretty-hrtime,rvagg/through2,rzwitserloot/lombok,salesforce/tough-cookie,sass/node-sass,scala/scala,sindresorhus/camelcase,sindresorhus/del,sindresorhus/find-up,sindresorhus/has-flag,sindresorhus/is-fullwidth-code-point,sindresorhus/load-json-file,sindresorhus/object-assign,sindresorhus/path-exists,sindresorhus/path-type,sindresorhus/pify,sindresorhus/read-pkg,sindresorhus/string-width,sindresorhus/strip-bom,spring-projects/spring-boot.git,substack/brfs,substack/minimist,substack/node-mkdirp,substack/node-wordwrap,thlorenz/browserify-shim,tj/commander.js,twbs/bootstrap,types/env-node,typicaljoe/taffydb,visionmedia/bytes.js,wesleytodd/setprototypeof,winstonjs/winston,yargs/cliui,yargs/yargs,yargs/yargs-parser,zeit/ms,zloirock/core-js' 2>>errors.txt | tee -a run.log || exit 2
GHA2DB_PROJECT=cii PG_DB=cii GHA2DB_LOCAL=1 GHA2DB_MGETC=y GHA2DB_SKIPTABLE=1 GHA2DB_INDEX=1 structure 2>>errors.txt | tee -a run.log || exit 3
GHA2DB_PROJECT=cii PG_DB=cii ./shared/setup_repo_groups.sh 2>>errors.txt | tee -a run.log || exit 4
GHA2DB_PROJECT=cii PG_DB=cii ./shared/import_affs.sh 2>>errors.txt | tee -a run.log || exit 5
GHA2DB_PROJECT=cii PG_DB=cii ./shared/setup_scripts.sh 2>>errors.txt | tee -a run.log || exit 6
GHA2DB_PROJECT=cii PG_DB=cii ./shared/get_repos.sh 2>>errors.txt | tee -a run.log || exit 7
GHA2DB_PROJECT=cii PG_DB=cii GHA2DB_LOCAL=1 vars || exit 8
./devel/ro_user_grants.sh cii || exit 9
./devel/psql_user_grants.sh devstats_team cii || exit 10