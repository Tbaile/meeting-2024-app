<?php

namespace App\Http\Controllers;

use App\Models\ShoppingItem;
use Illuminate\Http\Request;

class ShoppingListController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return view('shopping_list.index', [
            'shoppingItems' => ShoppingItem::all(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'item' => 'required|string',
            'quantity' => 'required|integer',
        ]);

        ShoppingItem::create($request->all());

        return redirect()->route('shopping-list.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ShoppingItem $shoppingItem)
    {
        $shoppingItem->delete();

        return redirect()->route('shopping-list.index');
    }
}
