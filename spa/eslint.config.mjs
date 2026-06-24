// @ts-check
import withNuxt from './.nuxt/eslint.config.mjs'

export default withNuxt(
  // Your custom configs here
  {
    ignores: ['./shared/client/**']
  },
  {
    rules: {
      'vue/block-order': ['error', {
        order: ['script', 'template', 'style']
      }]
    }
  }
)
