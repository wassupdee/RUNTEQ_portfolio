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
        'cream-pink': '#FFF1ED',
        'button-gray': '#6B6B6B'
      }
    }
  },
  plugins: [require("daisyui"),
    require('@tailwindcss/forms'),
    function({ addUtilities }) {
      const newUtilities = {
        ".text-shadow-gray": {
          textShadow: "0px 2px 3px darkgrey"
        },
        ".text-shadow-gray-md": {
          textShadow: "0px 3px 3px darkgrey"
        },
        ".text-shadow-gray-lg": {
          textShadow: "0px 5px 3px darkgrey"
        },
        ".text-shadow-gray-xl": {
          textShadow: "0px 7px 3px darkgrey"
        },
        ".text-shadow-gray-2xl": {
          textShadow: "0px 10px 3px darkgrey"
        },
        ".text-shadow-gray-none": {
          textShadow: "none"
        },
        ".text-shadow-white": {
          textShadow: "0px 2px 3px white"
        },
        ".text-shadow-white-md": {
          textShadow: "0px 3px 3px white"
        },
        ".text-shadow-white-lg": {
          textShadow: "0px 5px 3px white"
        },
        ".text-shadow-white-xl": {
          textShadow: "0px 7px 3px white"
        },
        ".text-shadow-white-2xl": {
          textShadow: "0px 10px 3px white"
        },
        ".text-shadow-white-none": {
          textShadow: "none"
        }
      };

      addUtilities(newUtilities);
    }
  ]
}
