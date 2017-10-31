module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    concat: {
      gopcss:{
        src:'css/**/*.css',
        dest:'css/all.css'
      }
    },
    clean: ['css/*'],
    sass: {
      dist: {
        files: [{
          expand: true,
          cwd: 'sass/',
          src: ['**/*.scss'],
          dest: 'css',
          ext: '.css'
        }]
      }
    },
    watch: {
      scripts: {
        files: ['**/*.js','**/*.scss'],
        tasks: ['clean','sass','concat'],
        options: {
          spawn: false
        }
      }
    }
  });
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.registerTask('default',['sass', 'concat', 'watch']);
}
