/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./templates/*.{html,js,py}", "./templates/**/*.{html,js,py}"],
    theme: {
        extend: {
            fontFamily: {
                rubik: ["Rubik", "sans-serif"],
                concert: ["Concert One", "sans-serif"],
            },
            colors: {
                "primary": "#346cb0"
            },
        },
    },
    plugins: [require("@tailwindcss/forms")],
    darkMode: "class",
};
