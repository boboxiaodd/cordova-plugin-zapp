const exec = require('cordova/exec');
const CDVZAPP = {
    zlog:function (success,fail,option){
        exec(success,fail,'CDVZAPP','zlog',[option]);
    }
};
module.exports = CDVZAPP;
