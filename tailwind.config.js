module.exports = {
  theme: {
    extend: {
      colors: {
        'white': '#ffffff',
        'light-blue': '#676f9d',
        'medium-blue': '#424769',
        'dark-blue': '#2d3250',
        'orange': '#f9b17a',
      },
    },
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/forms'),
    // ...
  ],
}
