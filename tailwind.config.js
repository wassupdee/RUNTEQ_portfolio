module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'golden': '#FFD700',
        'peach': '#FF6F61',
        'ivory': '#FFFFF0'
      }
    }
  },
  plugins: [require("daisyui")],
}
