var gulp = require('gulp'),
	sass = require('gulp-sass'),
	coffee = require('gulp-coffee'),
	jade = require('gulp-jade'),
	watch = require('gulp-watch'),
	notifier = require('gulp-notify');

var notify = function( error ) {
	notifier().write( error );
}

var paths = {
	styles: {
		src: 'resources/styles/*.scss',
		watch: ['resources/styles/*.scss', 'resources/styles/*/*.scss'],
		dest: 'build/styles'
	},
	scripts: {
		src: 'resources/scripts/*/*.coffee',
		dest: 'build/scripts'
	},
	views: {
		src: 'resources/views/*/*.jade',
		dest: 'build/views'
	}
}

var tasks = {
	styles: function() {
		gulp.src(paths.styles.src)
			.pipe(sass().on('error', notify))
			.pipe(gulp.dest(paths.styles.dest));
	},
	scripts: function() {
		gulp.src(paths.scripts.src)
			.pipe(coffee().on('error', notify))
			.pipe(gulp.dest(paths.scripts.dest));
	},
	views: function() {
		gulp.src(paths.views.src)
			.pipe(jade().on('error', notify))
			.pipe(gulp.dest(paths.views.dest));
	}
}

gulp.task( 'default', function() {
	tasks.styles();
	tasks.scripts();
	tasks.views();
});

gulp.task( 'watch', function() {
	watch(paths.styles.watch, tasks.styles);
	watch(paths.scripts.src, tasks.scripts);
	watch(paths.views.src, tasks.views);
});