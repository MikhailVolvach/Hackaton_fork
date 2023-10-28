/// <reference types='vitest' />
import { fileURLToPath, URL } from 'node:url';

import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { nxViteTsPaths } from '@nx/vite/plugins/nx-tsconfig-paths.plugin';

export default defineConfig({
  cacheDir: './node_modules/.vite/frontend',

  server: {
    port: 4200,
    proxy: {
      '/register/': {
        target: 'http://84.201.134.49:8000',
        changeOrigin: true
      }
    },
    host: '0.0.0.0',
  },

  preview: {
    port: 4300,
    host: '0.0.0.0',
  },

  plugins: [react(), nxViteTsPaths()],

  // Uncomment this if you are using workers.
  // worker: {
  //  plugins: [ nxViteTsPaths() ],
  // },

  test: {
    globals: true,
    cache: {
      dir: './node_modules/.vitest',
    },
    environment: 'jsdom',
    include: ['src/**/*.{test,spec}.{js,mjs,cjs,ts,mts,cts,jsx,tsx}'],
  },

  resolve: {
    alias: {
      "components": fileURLToPath(new URL("./src/components", import.meta.url)),
      "config": fileURLToPath(new URL("./src/config", import.meta.url)),
      "pages": fileURLToPath(new URL("./src/pages", import.meta.url)),
      "styles": fileURLToPath(new URL("./src/styles", import.meta.url)),
      "utils": fileURLToPath(new URL("./src/utils", import.meta.url)),
      "img": fileURLToPath(new URL("./src/assets/img", import.meta.url)),
      "store": fileURLToPath(new URL("./src/store", import.meta.url))
    }
  }
});
