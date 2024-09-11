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
        'peach-red': '#ff6f61',
        'peach-light': '#FFCFC4',
        'ivory-white': '#FFFFF7',
        'almond': '#FFEBCD',
        'sienna': '#C19A6B'
      }
    }
  },
  plugins: [require("daisyui")],
}
