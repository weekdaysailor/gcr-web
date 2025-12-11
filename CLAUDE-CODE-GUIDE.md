# Transitioning to Claude Code

## What's Been Done

I've set up the complete Hugo site structure with:

✅ **Site Structure**
- Complete Hugo directory layout
- Config file with menu structure
- Base templates (header, footer, layouts)
- Homepage template with content sections
- Single and list page templates

✅ **Styling & Scripts**
- Complete CSS with responsive design
- Mobile navigation JavaScript
- Smooth scrolling and interactions

✅ **Documentation**
- Comprehensive README
- Detailed migration checklist
- Helper scripts for common tasks

✅ **Files Ready**
All files are in: `/home/claude/gcr-site/`

## What's Next (For Claude Code)

### Immediate Next Steps

1. **Install Hugo** (if not already installed)
   ```bash
   # macOS
   brew install hugo
   
   # Windows
   choco install hugo-extended
   
   # Linux
   snap install hugo
   ```

2. **Navigate to the project**
   ```bash
   cd /path/to/gcr-site
   ```

3. **Start the development server**
   ```bash
   hugo server -D
   ```
   
   This will start a local server at http://localhost:1313 with hot reload

### Migration Tasks

Use the `migrate.sh` script or manually create content:

```bash
# Interactive menu
./migrate.sh

# Or create pages directly
./migrate.sh create about vision "Our Vision"
./migrate.sh presentation 2022 verge-2022 "VERGE 2022" "San Jose, CA"

# Check status
./migrate.sh status
```

### Priority Content Migration

1. **Start with About pages** - These are core content
   - Copy text from WordPress pages
   - Convert to Markdown
   - Add to content/about/ directory

2. **Add Rewards/Policy content**
   - The policy paper page is crucial
   - Add download links for PDFs

3. **Migrate Presentations**
   - Create pages for each presentation
   - Add images and download links
   - Organize by year

4. **Assets**
   - Download images from WordPress
   - Place in static/images/
   - Optimize file sizes

### Working with Claude Code

Claude Code excels at:
- **Batch operations**: "Create presentation pages for all 2023 presentations"
- **Content conversion**: "Convert this HTML to Markdown"
- **Asset management**: "Download and optimize all images from these URLs"
- **Template refinement**: "Add a featured presentations section to the homepage"
- **Testing**: "Check all internal links and list any broken ones"

### Example Claude Code Prompts

```
"Create content files for all the About section pages based on the current 
WordPress site at globalcarbonreward.org. Extract the content and convert 
to Markdown format."

"Download all presentation images from the WordPress site and optimize them 
for web. Place them in static/images/presentations/"

"Create a presentations list page that shows all presentations grouped by year 
with thumbnails and links"

"Add a contact form using FormSpree to the contact page"

"Test the site for broken links, missing images, and mobile responsiveness issues"
```

## File Locations Reference

**Content**: `content/` directory
- Homepage: `content/_index.md`
- About: `content/about/*.md`
- Rewards: `content/rewards/*.md`
- Presentations: `content/presentations/YEAR/*.md`

**Templates**: `layouts/` directory
- Base template: `layouts/_default/baseof.html`
- Homepage: `layouts/index.html`
- Single pages: `layouts/_default/single.html`

**Static Assets**: `static/` directory
- CSS: `static/css/main.css`
- JavaScript: `static/js/main.js`
- Images: `static/images/`
- Downloads: `static/downloads/`

**Configuration**: `config.toml` (root directory)

## Testing Your Work

```bash
# Run development server
hugo server -D

# View at http://localhost:1313

# Build for production
hugo --minify

# Output is in public/ directory
```

## Common Tasks

### Add a new page
1. Create file: `content/section/page-name.md`
2. Add front matter and content
3. View in browser (auto-reloads)

### Add images
1. Place in `static/images/`
2. Reference in Markdown: `![Alt text](/images/photo.jpg)`

### Update navigation
Edit `config.toml` menu section

### Add a shortcode
1. Create in `layouts/shortcodes/`
2. Use in content: `{{< shortcode-name >}}`

## Troubleshooting

**"Hugo not found"**
- Install Hugo (see above)

**"Changes not showing"**
- Check Hugo server is running
- Clear browser cache
- Check file syntax

**"Template not rendering"**
- Check template syntax
- Verify front matter
- Look for error messages in terminal

## Git Setup

When ready to commit:

```bash
git init
git add .
git commit -m "Initial Hugo site setup"
git remote add origin https://github.com/yourusername/gcr-site.git
git push -u origin main
```

## Deployment Options

1. **Netlify** (easiest):
   - Connect GitHub repo
   - Build command: `hugo --minify`
   - Publish directory: `public`

2. **GitHub Pages**:
   - Use GitHub Actions workflow
   - Auto-deploys on push

3. **Self-hosted**:
   - Build: `hugo --minify`
   - Copy `public/` to web server

## Questions?

- Check README.md for detailed documentation
- Check MIGRATION-CHECKLIST.md for task tracking
- Check Hugo docs: https://gohugo.io/documentation/

## Ready to Start?

1. ✅ Review this document
2. ⏳ Install Hugo
3. ⏳ Run `hugo server -D`
4. ⏳ Start migrating content
5. ⏳ Test and refine
6. ⏳ Deploy!

Good luck with the migration! The foundation is solid and ready for you to build on.
