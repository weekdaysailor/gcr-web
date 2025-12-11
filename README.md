# GCR Website Migration - Hugo Static Site

## Project Status

✅ **Completed:**
- Hugo site structure created
- Base templates (header, footer, homepage)
- CSS styling (responsive, clean design)
- JavaScript (mobile nav, smooth scroll)
- Configuration file with menu structure
- Basic content structure

🔄 **In Progress / Next Steps:**
- Content migration from WordPress
- Additional page templates
- Asset migration (images, audio files, PDFs)
- Contact form integration
- Testing and refinement

## Quick Start

### Prerequisites
```bash
# Install Hugo
# macOS:
brew install hugo

# Windows (Chocolatey):
choco install hugo-extended

# Linux:
snap install hugo
```

### Run Development Server
```bash
cd /path/to/gcr-site
hugo server -D

# Site will be available at http://localhost:1313
# Hot reloads automatically when files change
```

### Build for Production
```bash
hugo --minify
# Output in public/ directory
```

## Project Structure

```
gcr-site/
├── config.toml              # Site configuration & menus
├── content/                 # All content in Markdown
│   ├── _index.md           # Homepage content
│   ├── about/              # About section pages
│   ├── rewards/            # Rewards/policy pages
│   ├── presentations/      # Presentation archives
│   ├── contact/            # Contact pages
│   └── donate/             # Donation pages
├── layouts/                # HTML templates
│   ├── _default/
│   │   ├── baseof.html    # Base template (header/footer wrapper)
│   │   ├── single.html    # Template for single pages
│   │   └── list.html      # Template for list pages
│   ├── partials/
│   │   ├── header.html    # Site header with navigation
│   │   └── footer.html    # Site footer
│   ├── index.html         # Homepage template (special)
│   └── shortcodes/        # Reusable content snippets
├── static/                 # Static assets (served as-is)
│   ├── css/
│   │   └── main.css       # Main stylesheet
│   ├── js/
│   │   └── main.js        # Main JavaScript
│   ├── images/            # Images
│   ├── audio/             # Audio files
│   └── downloads/         # PDFs and downloads
└── public/                # Built site (generated, not in Git)
```

## Content Migration Guide

### Adding New Pages

Create new Markdown files in the content directory:

```bash
# Example: Add a new About page
hugo new about/vision.md
```

Edit the file:
```markdown
---
title: "Our Vision"
date: 2025-12-10
description: "The vision behind GCR"
---

## Our Vision

Content goes here in Markdown format...
```

### Content Front Matter

Each content file should have front matter (metadata):

```yaml
---
title: "Page Title"
date: 2025-12-10
description: "Page description for SEO"
draft: false              # Set to true to hide from production
menu:
  main:
    parent: "About"       # For dropdown menus
    weight: 1             # Order in menu
---
```

### Migration Tasks

#### Priority 1: Core Pages
- [ ] Homepage content (already templated, needs content refinement)
- [ ] About > Our Vision
- [ ] About > Our Mission
- [ ] About > Our Team
- [ ] Rewards > Introduction
- [ ] Rewards > Policy Paper
- [ ] Contact page
- [ ] Donate page

#### Priority 2: Presentations
Create pages for each presentation in `content/presentations/`:
- [ ] VERGE 2022
- [ ] SOCAP 2022
- [ ] Hong Kong 2022
- [ ] Ecocity 2023
- [ ] COP28 2023
- [ ] Amsterdam 2023
- [ ] Lund 2023
- [ ] Bard 2023
- [ ] Bank of England 2023
- [ ] NORD/LB 2024
- [ ] Zurich 2024
- [ ] Harvard 2025

Template for presentation pages:
```markdown
---
title: "VERGE 2022"
date: 2022-10-15
location: "San Jose, CA"
presentation_type: "conference"
featured_image: "/images/presentations/verge-2022.jpg"
video_url: "https://youtube.com/..."
downloads:
  - name: "Presentation Slides"
    url: "/downloads/verge-2022-slides.pdf"
---

## VERGE 2022 Presentation

Summary and content here...
```

#### Priority 3: Assets
- [ ] Download logo and brand images from WordPress site
- [ ] Download presentation images
- [ ] Download audio files
- [ ] Download PDF documents
- [ ] Optimize images (compress, resize)

## WordPress Content Export

### Option 1: Manual Copy-Paste
1. Open WordPress page
2. Copy content
3. Paste into Markdown file
4. Convert HTML to Markdown if needed

### Option 2: WordPress Export
```bash
# Export from WordPress
wp post list --post_type=page --format=json > pages.json

# You can then parse this to create Markdown files
```

### Option 3: Web Scraping
You can fetch content from the live site:
```bash
curl https://globalcarbonreward.org/our-vision/ > vision.html
# Then extract and convert to Markdown
```

## Customization

### Changing Colors
Edit `static/css/main.css`:
```css
:root {
    --primary-color: #2c5f2d;    /* Dark green */
    --secondary-color: #97bc62;   /* Light green */
    --text-color: #333;
    --bg-color: #fff;
}
```

### Updating Navigation
Edit `config.toml`:
```toml
[[menu.main]]
  name = "New Page"
  url = "/new-page/"
  weight = 6
```

### Adding Shortcodes
Create reusable content snippets in `layouts/shortcodes/`:

Example: Audio player shortcode (`layouts/shortcodes/audio.html`):
```html
<div class="audio-player">
    <audio controls>
        <source src="{{ .Get 0 }}" type="audio/mpeg">
        Your browser does not support the audio element.
    </audio>
</div>
```

Use in content:
```markdown
{{< audio "/audio/policy-summary.mp3" >}}
```

## Dynamic Features

### Contact Form (FormSpree)
1. Sign up at https://formspree.io
2. Get your form endpoint
3. Add form to contact page:

```html
<form action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
    <label>Name: <input type="text" name="name" required></label>
    <label>Email: <input type="email" name="_replyto" required></label>
    <label>Message: <textarea name="message" required></textarea></label>
    <button type="submit">Send</button>
</form>
```

### Newsletter Signup (Mailchimp)
Get embed code from Mailchimp and paste into your subscribe page.

## Testing Checklist

Before deploying:
- [ ] All pages load without errors
- [ ] Navigation works correctly
- [ ] Mobile menu functions
- [ ] Images display properly
- [ ] Links work (internal and external)
- [ ] Forms submit correctly
- [ ] Audio players work
- [ ] Downloads work
- [ ] Site looks good on mobile
- [ ] Site looks good on tablet
- [ ] Site looks good on desktop

## Deployment

### Option 1: GitHub Pages (Free)
```bash
# Build site
hugo --minify

# Initialize Git if not already done
git init
git add .
git commit -m "Initial GCR site"

# Create GitHub repo and push
gh repo create gcr-static-site --public
git remote add origin https://github.com/username/gcr-static-site.git
git push -u origin main

# Enable GitHub Pages in repo settings
# Or use GitHub Actions (workflow file needed)
```

### Option 2: Netlify (Easy, Free)
1. Push code to GitHub
2. Go to Netlify.com
3. "New site from Git"
4. Select your repo
5. Build command: `hugo --minify`
6. Publish directory: `public`
7. Deploy!

### Option 3: Your Desktop Server
```bash
# Build site
hugo --minify

# Copy to web server directory
sudo cp -r public/* /var/www/html/gcr/

# Or with rsync:
rsync -avz --delete public/ /var/www/html/gcr/
```

## Troubleshooting

### Hugo not found
```bash
# Check installation
hugo version

# If not installed, install it (see Prerequisites)
```

### Changes not showing
```bash
# Clear Hugo cache
hugo --cleanDestinationDir

# Force rebuild
hugo server --disableFastRender
```

### CSS not loading
- Check file path in baseof.html
- Ensure CSS is in static/css/
- Clear browser cache

### Menu not showing correctly
- Check config.toml menu structure
- Ensure parent names match exactly
- Check weight values for ordering

## Next Steps for Migration

1. **Install Hugo** on your local machine
2. **Clone/download this repository**
3. **Run `hugo server -D`** to see the site locally
4. **Start migrating content**:
   - Begin with high-priority pages
   - Copy content from WordPress
   - Convert to Markdown format
   - Add images to static/images/
5. **Test thoroughly**
6. **Deploy when ready**

## Resources

- Hugo Documentation: https://gohugo.io/documentation/
- Markdown Guide: https://www.markdownguide.org/
- FormSpree: https://formspree.io/
- Netlify: https://www.netlify.com/
- GitHub Pages: https://pages.github.com/

## Questions?

Document issues and questions as you work through the migration. Add them to a NOTES.md file or create GitHub issues.

---

**Site created:** December 2025
**Framework:** Hugo Static Site Generator
**Original site:** WordPress (globalcarbonreward.org)
