// uno.config.ts
import {
  defineConfig,
  presetTypography,
  presetWind,
} from 'unocss'

import transformerDirectives from '@unocss/transformer-directives'

export default defineConfig({
  content: {
    pipeline: {
      include: [
        /\.(vue|svelte|[jt]sx|mdx?|astro|elm|php|phtml|html|html\.erb)($|\?)/,
      ]
    },
    filesystem: [
      '../../app/views/**/*.html.erb',
    ],
  },
  presets: [
    presetWind(),
    presetTypography(),
  ],
  transformers: [
    transformerDirectives(),
  ],
})
