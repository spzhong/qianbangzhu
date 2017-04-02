package com.quqian.util.view;

import java.util.List;

/**
 * The simple Array wheel adapter
 * 
 * @param <T>
 *            the element type
 */
public class ListWheelAdapter<T> implements WheelAdapter {

    // items
    private List<T> items;

    /**
     * Constructor
     * 
     * @param items
     *            the items
     */
    public ListWheelAdapter(List<T> items) {
        this.items = items;
    }

    @Override
    public String getItem(int index) {
        if (index >= 0 && index < items.size()) {
            return items.get(index).toString();
        }
        return null;
    }

    @Override
    public int getItemsCount() {
        return items.size();
    }

    @Override
    public int getMaximumLength() {
        return items.size();
    }

}
