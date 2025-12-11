#!/bin/bash

# GCR Content Migration Helper Script
# This script helps with common migration tasks

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$SCRIPT_DIR/content"
STATIC_DIR="$SCRIPT_DIR/static"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}GCR Migration Helper${NC}"
echo "===================="
echo ""

# Function to create a new page
create_page() {
    local section=$1
    local slug=$2
    local title=$3
    
    local filepath="$CONTENT_DIR/$section/$slug.md"
    
    if [ -f "$filepath" ]; then
        echo -e "${RED}Error: File already exists: $filepath${NC}"
        return 1
    fi
    
    mkdir -p "$(dirname "$filepath")"
    
    cat > "$filepath" <<EOF
---
title: "$title"
date: $(date +%Y-%m-%d)
description: "Description for $title"
draft: false
---

## $title

Content goes here...
EOF
    
    echo -e "${GREEN}✓ Created: $filepath${NC}"
}

# Function to create a presentation page
create_presentation() {
    local year=$1
    local slug=$2
    local title=$3
    local location=$4
    
    local dirpath="$CONTENT_DIR/presentations/$year"
    local filepath="$dirpath/$slug.md"
    
    mkdir -p "$dirpath"
    
    if [ -f "$filepath" ]; then
        echo -e "${RED}Error: File already exists: $filepath${NC}"
        return 1
    fi
    
    cat > "$filepath" <<EOF
---
title: "$title"
date: $year-01-01
location: "$location"
presentation_type: "conference"
featured_image: "/images/presentations/$slug.jpg"
video_url: ""
downloads:
  - name: "Presentation Slides"
    url: "/downloads/$slug-slides.pdf"
---

## $title

Presentation overview...

### Key Points

- Point 1
- Point 2
- Point 3

### Resources

[Add any additional resources here]
EOF
    
    echo -e "${GREEN}✓ Created presentation: $filepath${NC}"
}

# Function to download and optimize an image
download_image() {
    local url=$1
    local destination=$2
    
    echo "Downloading image from: $url"
    echo "Saving to: $destination"
    
    mkdir -p "$(dirname "$destination")"
    
    if command -v curl >/dev/null 2>&1; then
        curl -L -o "$destination" "$url"
        echo -e "${GREEN}✓ Downloaded: $destination${NC}"
    else
        echo -e "${RED}Error: curl not found. Please install curl.${NC}"
        return 1
    fi
}

# Function to list all pages that need migration
list_todos() {
    echo -e "${BLUE}Pages that need to be migrated:${NC}"
    echo ""
    
    echo "About Section:"
    echo "  - Our Vision"
    echo "  - Our Mission"
    echo "  - Our Plan"
    echo "  - Founder's Message"
    echo "  - Our Team"
    echo "  - Our Logo"
    echo ""
    
    echo "Rewards Section:"
    echo "  - Introduction"
    echo "  - Policy Paper"
    echo ""
    
    echo "Presentations (multiple years - see MIGRATION-CHECKLIST.md)"
    echo ""
    
    echo "Contact Section:"
    echo "  - Subscribe"
    echo "  - Contact"
    echo "  - Partner"
    echo ""
    
    echo "Donate Section:"
    echo "  - Main page"
    echo "  - PayPal"
    echo "  - Credit Card"
    echo "  - Check"
    echo "  - Donor Advised Funds"
}

# Function to check site status
check_status() {
    echo -e "${BLUE}Checking site status...${NC}"
    echo ""
    
    # Count content files
    local content_count=$(find "$CONTENT_DIR" -name "*.md" | wc -l)
    echo "Content files: $content_count"
    
    # Count images
    local image_count=$(find "$STATIC_DIR/images" -type f 2>/dev/null | wc -l)
    echo "Images: $image_count"
    
    # Check if Hugo is installed
    if command -v hugo >/dev/null 2>&1; then
        echo -e "${GREEN}✓ Hugo is installed: $(hugo version | head -n1)${NC}"
    else
        echo -e "${RED}✗ Hugo is not installed${NC}"
        echo "  Install: brew install hugo (macOS) or visit https://gohugo.io/installation/"
    fi
    
    echo ""
    echo "Next steps:"
    echo "1. Run: hugo server -D"
    echo "2. Visit: http://localhost:1313"
    echo "3. Start migrating content!"
}

# Main menu
show_menu() {
    echo ""
    echo "What would you like to do?"
    echo "1. Create a new page"
    echo "2. Create a presentation page"
    echo "3. Download an image"
    echo "4. List migration TODOs"
    echo "5. Check site status"
    echo "6. Start Hugo server"
    echo "7. Build site"
    echo "8. Exit"
    echo ""
    read -p "Choose an option (1-8): " choice
    
    case $choice in
        1)
            read -p "Section (e.g., about, rewards, contact): " section
            read -p "Slug (e.g., vision, policy-paper): " slug
            read -p "Title: " title
            create_page "$section" "$slug" "$title"
            show_menu
            ;;
        2)
            read -p "Year (e.g., 2024): " year
            read -p "Slug (e.g., verge-2022): " slug
            read -p "Title: " title
            read -p "Location: " location
            create_presentation "$year" "$slug" "$title" "$location"
            show_menu
            ;;
        3)
            read -p "Image URL: " url
            read -p "Destination path (relative to static/): " dest
            download_image "$url" "$STATIC_DIR/$dest"
            show_menu
            ;;
        4)
            list_todos
            show_menu
            ;;
        5)
            check_status
            show_menu
            ;;
        6)
            echo -e "${GREEN}Starting Hugo development server...${NC}"
            hugo server -D
            ;;
        7)
            echo -e "${GREEN}Building site...${NC}"
            hugo --minify
            echo -e "${GREEN}✓ Site built successfully!${NC}"
            echo "Output directory: $SCRIPT_DIR/public/"
            show_menu
            ;;
        8)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            show_menu
            ;;
    esac
}

# If no arguments, show menu
if [ $# -eq 0 ]; then
    show_menu
else
    # Handle command line arguments
    case $1 in
        create)
            if [ $# -lt 4 ]; then
                echo "Usage: $0 create <section> <slug> <title>"
                exit 1
            fi
            create_page "$2" "$3" "$4"
            ;;
        presentation)
            if [ $# -lt 5 ]; then
                echo "Usage: $0 presentation <year> <slug> <title> <location>"
                exit 1
            fi
            create_presentation "$2" "$3" "$4" "$5"
            ;;
        status)
            check_status
            ;;
        list)
            list_todos
            ;;
        server)
            hugo server -D
            ;;
        build)
            hugo --minify
            ;;
        *)
            echo "Unknown command: $1"
            echo "Available commands: create, presentation, status, list, server, build"
            exit 1
            ;;
    esac
fi
