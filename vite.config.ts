import {defineConfig} from 'vite';
import react from '@vitejs/plugin-react';
export default defineConfig({plugins:[react()],build:{outDir:'dist',rollupOptions:{output:{manualChunks:{react:['react','react-dom'],time:['luxon']}}}},server:{host:'127.0.0.1',watch:{ignored:['**/data/**','**/artifacts/**','**/.render-bundle/**','**/.npm-cache/**','**/fixtures/**']},fs:{deny:['**/.env','**/.env.*','**/data/**','**/artifacts/**','**/fixtures/**','**/server/**','**/.render-bundle/**','**/.git/**']}}});
