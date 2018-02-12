var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');


var monk = require('monk');

var db = monk("mongodb://masterroot:masterroot@ds233208.mlab.com:33208/pubnub-chat");


var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(function(req, res, next)
    {
        req.db = db;
        next();
    }
);

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

// Routes
var index = require('./routes/index');
var add_class = require('./routes/add_class');

// Use
app.use('/', index);
app.use('/add_class', add_class);



module.exports = app;



app.set('port', (process.env.PORT || 5000));
app.listen(app.get('port'), function () {
    console.log('Node app is running on port', app.get('port'));
});