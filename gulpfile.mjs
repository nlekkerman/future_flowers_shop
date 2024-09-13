import gulp from 'gulp';
import cleanCSS from 'gulp-clean-css';
import concat from 'gulp-concat';
import autoprefixer from 'gulp-autoprefixer';

const paths = {
  css: {
    src: 'src/css/**/*.css', // All CSS files in src/css directory
    dest: 'static/dist/css' // Output destination for processed CSS
  },
  sass: {
    src: 'src/sass/**/*.scss', // All SCSS files in src/sass directory
    dest: 'static/dist/css' // Output destination for compiled SCSS
  }
};

// Task to process CSS files (concatenate, autoprefix, minify)
export function styles() {
  return gulp.src(paths.css.src) // Get all CSS files
    .pipe(concat('styles.css')) // Concatenate them into a single file
    .pipe(autoprefixer({
      cascade: false
    })) // Add vendor prefixes
    .pipe(cleanCSS()) // Minify the CSS
    .pipe(gulp.dest(paths.css.dest)); // Output the final CSS
}

// Watch files for changes
export function watch() {
  gulp.watch(paths.css.src, styles); // Watch for CSS changes
}

// Export default task
export default gulp.series(styles, watch);
