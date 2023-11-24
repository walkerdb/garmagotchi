# How This Works

This is a collection of all the drawable Garmagatchi characters that can be used.

For a custom garmagotchi avatar, `resources/drawables/me` folder must contain the following assets in SVG format with the corresponding names:

1. `accessories_cold.svg`
2. `accessories_hot.svg`
3. `body.svg`
4. `expression_default_blink.svg`
5. `expression_default.svg`
6. `expression_heh.svg`
7. `expression_high_hr.svg`
8. `expression_past_bedtime.svg`
9. `hands.svg`
10. `head.svg`
11. `partner_kiss.svg`
12. `partner_sparkle.svg`
13. `partner_squish.svg`
14. `partner.svg`

# How To Load A Different Character

To load up a different character, simply replace the `me` folder's assets with the assets of character you want to use.

Some notes on the assets based on the current implementation:

- They must be in SVG format.
- There are 14 assets in total that are needed to make up a character and its animations.
- The names of the assets must be exactly as they are listed above.
- I would recommend using the following dimensions for your SVG: 416x416px.
