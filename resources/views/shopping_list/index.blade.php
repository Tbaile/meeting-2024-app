<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Items to shop: {{ $shoppingItems->count() }} </h1>
    <ol>
        @foreach ($shoppingItems as $item)
            <li>{{ $item->item }}: {{ $item->quantity }} 
            <form id="delete-form-{{ $item->id }}" action="{{ route('shopping-list.destroy', $item->id) }}" method="POST" style="display: inline;">
                @csrf
                @method('DELETE')
                <button type="submit" onclick="return confirm('Are you sure you want to delete this item?');">Remove</button>
            </form>
            </li>
        @endforeach
    </ol>

    <form action="{{ route('shopping-list.store') }}" method="POST">
        @csrf
        <input type="text" name="item" placeholder="Enter item name">
        <input type="number" name="quantity" placeholder="Enter quantity">
        <button type="submit">Add item</button>
    </form>
</body>
</html>