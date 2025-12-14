// Mobile Navigation Toggle
document.addEventListener('DOMContentLoaded', function() {
    const navToggle = document.querySelector('.nav-toggle');
    const navMenu = document.querySelector('.nav-menu');

    if (navToggle) {
        navToggle.addEventListener('click', function(e) {
            e.stopPropagation();
            navMenu.classList.toggle('active');
        });
    }

    // Mobile dropdown toggle functionality
    const isMobile = () => window.innerWidth <= 778;

    const handleDropdownToggle = function(e) {
        // Only intercept on mobile devices
        if (isMobile()) {
            e.preventDefault();
            e.stopPropagation();

            const parentItem = this.closest('.has-dropdown');

            // Close all other dropdowns
            document.querySelectorAll('.has-dropdown').forEach(item => {
                if (item !== parentItem) {
                    item.classList.remove('dropdown-open');
                }
            });

            // Toggle this dropdown
            parentItem.classList.toggle('dropdown-open');
        }
    };

    document.querySelectorAll('.has-dropdown > .nav-link').forEach(link => {
        // Handle both click and touch events for better mobile support
        link.addEventListener('click', handleDropdownToggle);
        link.addEventListener('touchend', function(e) {
            if (isMobile()) {
                e.preventDefault();
                handleDropdownToggle.call(this, e);
            }
        });
    });

    // Close mobile menu when clicking outside
    document.addEventListener('click', function(event) {
        if (navMenu && !event.target.closest('.main-nav')) {
            navMenu.classList.remove('active');
            // Also close any open dropdowns
            document.querySelectorAll('.has-dropdown').forEach(item => {
                item.classList.remove('dropdown-open');
            });
        }
    });

    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add active state to current page in nav
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-link').forEach(link => {
        const linkPath = link.getAttribute('href');
        if (linkPath === currentPath || (currentPath !== '/' && currentPath.startsWith(linkPath) && linkPath !== '/')) {
            link.classList.add('active');
        }
    });

    initAnalyticsTracking();
    initCarousels();
});

/**
 * Adds lightweight analytics hooks for CTA tracking.
 */
function initAnalyticsTracking() {
    const body = document.body;
    if (!body || !body.dataset.gaId || typeof window.gtag !== 'function') {
        return;
    }

    const fireAnalyticsEvent = (name, params = {}) => {
        if (typeof window.gtag !== 'function') {
            return;
        }
        const payload = {
            event_category: 'engagement',
            event_label: window.location.pathname,
            page_path: window.location.pathname
        };

        Object.keys(params).forEach(key => {
            const value = params[key];
            if (value !== undefined && value !== null && value !== '') {
                payload[key] = value;
            }
        });

        window.gtag('event', name, payload);
    };

    document.querySelectorAll('[data-analytics-event]').forEach(element => {
        element.addEventListener('click', () => {
            const eventName = element.dataset.analyticsEvent;
            if (!eventName) {
                return;
            }
            fireAnalyticsEvent(eventName, {
                event_category: element.dataset.analyticsCategory,
                event_label: element.dataset.analyticsLabel,
                value: element.dataset.analyticsValue ? Number(element.dataset.analyticsValue) : undefined,
                link_url: element.getAttribute('href'),
                link_text: element.textContent.trim()
            });
        });
    });

    document.querySelectorAll('a[href*="/donate"]').forEach(link => {
        if (link.dataset.analyticsEvent) {
            return;
        }
        link.addEventListener('click', () => {
            fireAnalyticsEvent('donate_cta_click', {
                event_category: 'donations',
                link_url: link.href,
                link_text: link.textContent.trim()
            });
        });
    });
}

/**
 * Initializes simple carousels for audience pages.
 */
function initCarousels() {
    document.querySelectorAll('[data-carousel]').forEach(carousel => {
        const track = carousel.querySelector('.carousel-track');
        const slides = carousel.querySelectorAll('.carousel-card');
        const prev = carousel.querySelector('[data-carousel-prev]');
        const next = carousel.querySelector('[data-carousel-next]');
        const dots = carousel.querySelectorAll('[data-carousel-dot]');
        if (!track || slides.length === 0) {
            return;
        }

        let index = 0;

        const update = () => {
            track.style.transform = `translateX(-${index * 100}%)`;
            dots.forEach(dot => dot.classList.remove('active'));
            if (dots[index]) {
                dots[index].classList.add('active');
            }
        };

        prev?.addEventListener('click', () => {
            index = (index - 1 + slides.length) % slides.length;
            update();
        });

        next?.addEventListener('click', () => {
            index = (index + 1) % slides.length;
            update();
        });

        dots.forEach(dot => {
            dot.addEventListener('click', () => {
                const targetIndex = Number(dot.dataset.index);
                if (!Number.isNaN(targetIndex)) {
                    index = targetIndex;
                    update();
                }
            });
        });
    });
}
