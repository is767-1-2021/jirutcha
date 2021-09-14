class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward)),
          IconButton(onPressed: (){}, icon: Icon(Icons.agriculture)),
          IconButton(onPressed: (){}, icon: Icon(Icons.bus_alert)),
          IconButton(onPressed: (){}, icon: Icon(Icons.medication)),
          IconButton(onPressed: (){}, icon: Icon(Icons.food_bank)),
        ],
      ),
    );
  }
} 
