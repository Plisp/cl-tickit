#include <tickit.h>

/* return struct -> return pointer to struct */

TickitPenRGB8* tickit_pen_get_colour_attr_rgb8_ptr(const TickitPen *pen, TickitPenAttr attr)
{
	TickitPenRGB8 *copy = malloc(sizeof(TickitPenRGB8));
	*copy = tickit_pen_get_colour_attr_rgb8(pen, attr);
	return copy;
}

TickitRenderBufferLineMask* tickit_renderbuffer_get_cell_linemask_ptr(TickitRenderBuffer *rb, int line, int col)
{
	TickitRenderBufferLineMask *copy = malloc(sizeof(TickitRenderBufferLineMask));
	*copy = tickit_renderbuffer_get_cell_linemask(rb, line, col);
	return copy;
}

TickitRect* tickit_window_get_geometry_ptr(const TickitWindow *win)
{
	TickitRect *copy = malloc(sizeof(TickitRect));
	*copy = tickit_window_get_geometry(win);
	return copy;
}
TickitRect* tickit_window_get_abs_geometry_ptr(const TickitWindow *win)
{
	TickitRect *copy = malloc(sizeof(TickitRect));
	*copy = tickit_window_get_abs_geometry(win);
	return copy;
}

/* pass by value -> pass pointer */

void tickit_pen_set_colour_attr_rgb8_ptr(TickitPen *pen, TickitPenAttr attr, TickitPenRGB8 *value)
{
	tickit_pen_set_colour_attr_rgb8(pen, attr, *value);
}

bool tickit_term_scrollrect_ptr(TickitTerm *tt, TickitRect *rect, int downward, int rightward)
{
	return tickit_term_scrollrect(tt, *rect, downward, rightward);
}

TickitWindow *tickit_window_new_ptr(TickitWindow *parent, TickitRect *rect, TickitWindowFlags flags)
{
	return tickit_window_new(parent, *rect, flags);
}

void tickit_window_set_geometry_ptr(TickitWindow *win, TickitRect *rect)
{
	tickit_window_set_geometry(win, *rect);
}
