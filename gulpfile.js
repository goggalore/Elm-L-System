const gulp = require('gulp');
const rollup = require('rollup-stream');
const source = require('vinyl-source-stream');

gulp.task('rollup', () => {
    return rollup({
        input: 'src/js/port.js',
        format: 'iife',
    })
    .pipe(source('port.js'))
    .pipe(gulp.dest('./build'))
    .pipe(gulp.dest('./docs/build'));
});

gulp.task('default', gulp.series('rollup'), () => {
    gulp.watch(['./src/js/port']);
});