// uno.config.ts
import {
  defineConfig,
  presetTypography,
  presetUno
} from 'unocss'


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
    presetUno(),
    presetTypography(),
  ]
})
