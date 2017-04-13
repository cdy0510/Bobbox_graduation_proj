Number.prototype.format = function(){
    if(this==0) return 0;
 
    var r = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
 
    while (r.test(n)) n = n.replace(r, '$1' + ',' + '$2');
 
    return n;
};

String.prototype.format = function(){
    var n = parseFloat(this);
    if( isNaN(n) ) return "0";
 
    return n.format();
};