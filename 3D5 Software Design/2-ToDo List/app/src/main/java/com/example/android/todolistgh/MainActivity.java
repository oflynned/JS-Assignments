package com.example.android.todolistgh;

import android.app.DialogFragment;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.internal.view.ContextThemeWrapper;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    SharedPreferences sharedPreferences;
    SharedPreferences.Editor editor;

    boolean dateOrdered, categoryOrdered, descriptionOrdered, allChecked;
    int ordering;
    String data;

    DatabaseHelper databaseHelper;

    Button addButton, memoButton;
    TableLayout tableLayout;
    ArrayList<CheckBox> checkBoxes;
    CheckBox totalCheckBox;
    TextView orderByDate, orderByCategory, orderByDescription, clearButton;
    com.getbase.floatingactionbutton.FloatingActionButton actionAdd;
    com.getbase.floatingactionbutton.FloatingActionButton actionMemo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        sharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
        editor = sharedPreferences.edit();
        ordering = sharedPreferences.getInt(getResources().getString(R.string.pref_key_ordering), 8);

        clearButton = (TextView) findViewById(R.id.clearAllTasks);
        tableLayout = (TableLayout) findViewById(R.id.list_table);
        totalCheckBox = (CheckBox) findViewById(R.id.select_all);
        actionAdd = (com.getbase.floatingactionbutton.FloatingActionButton) findViewById(R.id.action_a);
        actionMemo = (com.getbase.floatingactionbutton.FloatingActionButton) findViewById(R.id.action_b);


        checkBoxes = new ArrayList<>();
        checkBoxes = new ArrayList<>();

        orderByDate = (TextView) findViewById(R.id.dateTitle);
        orderByCategory = (TextView) findViewById(R.id.categoryTitle);
        orderByDescription = (TextView) findViewById(R.id.descriptionTitle);

        databaseHelper = new DatabaseHelper(this);

        populateTable(DatabaseHelper.SELECT_ALL_QUERY);
        databaseHelper.printTableContents(Database.TasksTable.TABLE_NAME);

        orderTable();

        totalCheckBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                SQLiteDatabase readDb = databaseHelper.getReadableDatabase();
                Cursor cursor = readDb.rawQuery(DatabaseHelper.SELECT_ALL_QUERY, null);
                cursor.moveToFirst();
                int rows = cursor.getCount();

                if (isChecked) {
                    setAllChecked(true);
                    for (int i = 0; i < rows; i++) {
                        databaseHelper.editChecked(cursor.getInt(0), true);
                        cursor.moveToNext();
                    }
                } else {
                    setAllChecked(false);
                    for (int i = 0; i < rows; i++) {
                        databaseHelper.editChecked(cursor.getInt(0), false);
                        cursor.moveToNext();
                    }
                }
                tableLayout.invalidate();
                orderTable();
                readDb.close();
                cursor.close();
            }
        });


        orderByDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!isDateOrdered()) {
                    editor.putInt(getResources().getString(R.string.pref_key_ordering), 1);
                    editor.apply();
                    setDateOrdered(true);
                    tableLayout.invalidate();
                    populateTable(DatabaseHelper.SELECT_BY_DATE_ASCENDING);
                    Toast.makeText(getBaseContext(), "Ordered by ascending date",
                            Toast.LENGTH_SHORT).show();
                } else {
                    editor.putInt(getResources().getString(R.string.pref_key_ordering), 0);
                    editor.apply();
                    setDateOrdered(false);
                    tableLayout.invalidate();
                    populateTable(DatabaseHelper.SELECT_BY_DATE_DESCENDING);
                    Toast.makeText(getBaseContext(), "Ordered by descending date",
                            Toast.LENGTH_SHORT).show();
                }
            }
        });

        orderByCategory.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!isCategoryOrdered()) {
                    editor.putInt(getResources().getString(R.string.pref_key_ordering), 3);
                    editor.apply();
                    setCategoryOrdered(true);
                    tableLayout.invalidate();
                    populateTable(DatabaseHelper.SELECT_BY_CATEGORY_ASCENDING);
                    Toast.makeText(getBaseContext(), "Ordered by ascending category alphabetically",
                            Toast.LENGTH_SHORT).show();
                } else {
                    editor.putInt(getResources().getString(R.string.pref_key_ordering), 2);
                    editor.apply();
                    setCategoryOrdered(false);
                    tableLayout.invalidate();
                    populateTable(DatabaseHelper.SELECT_BY_CATEGORY_DESCENDING);
                    Toast.makeText(getBaseContext(), "Ordered by descending category alphabetically",
                            Toast.LENGTH_SHORT).show();
                }
            }
        });

        orderByDescription.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(!isDescriptionOrdered()){
                    editor.putInt(getResources().getString(R.string.pref_key_ordering), 5);
                    editor.apply();
                    setDescriptionOrdered(true);
                    tableLayout.invalidate();
                    populateTable(DatabaseHelper.SELECT_BY_DESCRIPTION_ASCENDING);
                    Toast.makeText(getBaseContext(), "Ordered by ascending description alphabetically",
                            Toast.LENGTH_SHORT).show();
                } else {
                    editor.putInt(getResources().getString(R.string.pref_key_ordering), 4);
                    editor.apply();
                    setDescriptionOrdered(false);
                    tableLayout.invalidate();
                    populateTable(DatabaseHelper.SELECT_BY_DESCRIPTION_DESCENDING);
                    Toast.makeText(getBaseContext(), "Ordered by descending description alphabetically",
                            Toast.LENGTH_SHORT).show();
                }
            }
        });

        clearButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                databaseHelper.removeAllTasks();
                tableLayout.invalidate();
                populateTable(DatabaseHelper.SELECT_ALL_QUERY);
            }
        });

        actionAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                final AddTaskDialog addTaskDialog = new AddTaskDialog();
                addTaskDialog.show(MainActivity.this.getFragmentManager(), "setAddDialogListener");
                addTaskDialog.setAddDialogListener(new AddTaskDialog.setAddTaskListener() {
                    @Override
                    public void onDoneClick(DialogFragment dialogFragment) {
                        if (addTaskDialog.getDateField().matches("") &&
                                addTaskDialog.getCategory().matches("") &&
                                addTaskDialog.getDescription().matches("")) {
                            Toast.makeText(MainActivity.this, "Please enter all fields", Toast.LENGTH_SHORT).show();
                        } else {
                            if (addTaskDialog.getDateField().matches("")) {
                                Toast.makeText(MainActivity.this, "Please add a date",
                                        Toast.LENGTH_SHORT).show();
                            }
                            if (addTaskDialog.getCategory().matches("")) {
                                Toast.makeText(MainActivity.this, "Please add a category",
                                        Toast.LENGTH_SHORT).show();
                            }
                            if (addTaskDialog.getDescription().matches("")) {
                                Toast.makeText(MainActivity.this, "Please add a description",
                                        Toast.LENGTH_SHORT).show();
                            }
                            if (!addTaskDialog.getDateField().matches("")
                                    && !addTaskDialog.getCategory().matches("")
                                    && !addTaskDialog.getDescription().matches("")) {
                                databaseHelper.insertTask(addTaskDialog.getCategory(),
                                        addTaskDialog.getDescription(),
                                        addTaskDialog.getDate(),
                                        addTaskDialog.getRawDate(),
                                        false,
                                        addTaskDialog.getPriority());
                                databaseHelper.printTableContents(Database.TasksTable.TABLE_NAME);
                                tableLayout.invalidate();
                                populateTable(DatabaseHelper.SELECT_ALL_QUERY);
                                Toast.makeText(MainActivity.this, "Task Added Successfully!",
                                        Toast.LENGTH_SHORT).show();
                            }
                        }
                        /*NotificationHandler notification = new NotificationHandler(MainActivity.this);
                        SQLiteDatabase readDb = databaseHelper.getReadableDatabase();
                        Cursor cursor = readDb.rawQuery(DatabaseHelper.SELECT_ALL_QUERY, null);
                        for(int i = 1; i <= cursor.getCount(); i++)
                        {
                            setData(i, DatabaseHelper.COL_DUE_DATE);
                            String date = getData();
                            setData(i, DatabaseHelper.COL_DESCRIPTION);
                            String description = getData();
                            notification.showNotification(date, description);
                        }*/
                    }
                });

            }
        });

        actionMemo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                    startActivity(new Intent(getBaseContext(), SyncActivity.class));
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    public void setDateOrdered(boolean dateOrdered){this.dateOrdered=dateOrdered;}
    public boolean isDateOrdered(){return dateOrdered;}
    public void setCategoryOrdered(boolean categoryOrdered){this.categoryOrdered=categoryOrdered;}
    public boolean isCategoryOrdered(){return categoryOrdered;}
    public void setDescriptionOrdered(boolean descriptionOrdered){this.descriptionOrdered=descriptionOrdered;}
    public boolean isDescriptionOrdered(){return descriptionOrdered;}
    public void setAllChecked(boolean allChecked){this.allChecked=allChecked;}
    public boolean isAllChecked(){return allChecked;}

    public void orderTable(){
        this.ordering = sharedPreferences.getInt(getResources().getString(R.string.pref_key_ordering), 8);
        switch (ordering){
            //date descending
            case 0:
                tableLayout.invalidate();
                populateTable(DatabaseHelper.SELECT_BY_DATE_DESCENDING);
                break;
            //date ascending
            case 1:
                tableLayout.invalidate();
                populateTable(DatabaseHelper.SELECT_BY_DATE_ASCENDING);
                break;
            //category descending
            case 2:
                tableLayout.invalidate();
                populateTable(DatabaseHelper.SELECT_BY_CATEGORY_DESCENDING);
                break;
            //category ascending
            case 3:
                tableLayout.invalidate();
                populateTable(DatabaseHelper.SELECT_BY_CATEGORY_ASCENDING);
                break;
            //description descending
            case 4:
                tableLayout.invalidate();
                populateTable(DatabaseHelper.SELECT_BY_DESCRIPTION_DESCENDING);
                break;
            //description ascending
            case 5:
                tableLayout.invalidate();
                populateTable(DatabaseHelper.SELECT_BY_DESCRIPTION_ASCENDING);
                break;
            //priority descending
            case 6:
                break;
            //priority ascending
            case 7:
                break;
            //by id ascending default
            default:
                tableLayout.invalidate();
                populateTable(DatabaseHelper.SELECT_ALL_QUERY);
                break;
        }
    }

    /**
     * populates the database rows and columns into a programmatically added layout
     */
    public void populateTable(String query) {
        SQLiteDatabase readDb = databaseHelper.getReadableDatabase();

        final int currNumRows = tableLayout.getChildCount();
        if (currNumRows > 1)
            tableLayout.removeViewsInLayout(1, currNumRows - 1);

        final Cursor cursor = readDb.rawQuery(query, null);
        int numRows = cursor.getCount();
        System.out.println("Row count " + numRows);
        cursor.moveToFirst();

        for (int i = 0; i < numRows; i++) {
            final TableRow tableRow = new TableRow(this);
            TableRow.LayoutParams tableRowParams =
                    new TableRow.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                            ViewGroup.LayoutParams.WRAP_CONTENT);
            tableRow.setLayoutParams(tableRowParams);

            //assign row via ID instantiation
            final int row = cursor.getInt(DatabaseHelper.COL_ID);

            //date
            final TextView dateField = new TextView(this);
            dateField.setText(cursor.getString(DatabaseHelper.COL_DUE_DATE));
            dateField.setGravity(Gravity.CENTER);

            //category
            final TextView categoryField = new TextView(this);
            categoryField.setText(cursor.getString(DatabaseHelper.COL_CATEGORY));
            categoryField.setGravity(Gravity.CENTER);

            //description
            final TextView descField = new TextView(this);
            descField.setText(cursor.getString(DatabaseHelper.COL_DESCRIPTION));
            descField.setGravity(Gravity.CENTER);

            //priority
            final TextView priField = new TextView(this);
            if(cursor.getInt(DatabaseHelper.COL_PRIORITY) == 1){
                priField.setText("!");
                //priField.setTextColor(getResources().getColor(R.color.red));
                priField.setTypeface(null, Typeface.BOLD);

            } else {
                priField.setText("");
            }
            priField.setGravity(Gravity.CENTER);

            if (i % 2 == 0) {
                tableRow.setBackgroundColor(ContextCompat
                        .getColor(getBaseContext(), R.color.colorPrimary));
                dateField.setTextColor(Color.WHITE);
                categoryField.setTextColor(Color.WHITE);
                descField.setTextColor(Color.WHITE);
                priField.setTextColor(Color.WHITE);
            }

            final CheckBox checkBox = new CheckBox(this);
            checkBox.setId(cursor.getInt(0));
            checkBoxes.add(checkBox);
            if(cursor.getInt(6) == 1){
                checkBox.setChecked(true);
                strikeThrough(dateField, categoryField, descField, priField, true);
                //priField.setTextColor(getResources().getColor(R.color.red));

                tableLayout.invalidate();
            } else {
                checkBox.setChecked(false);
                strikeThrough(dateField, categoryField, descField, priField, false);
                tableLayout.invalidate();
            }

            checkBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
                @Override
                public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                    databaseHelper.editChecked(row, isChecked);
                    strikeThrough(dateField, categoryField, descField, priField, isChecked);
                    databaseHelper.printTableContents(Database.TasksTable.TABLE_NAME);
                }
            });

            tableRow.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View v) {
                    final AlertDialog.Builder builder = new AlertDialog.Builder(
                            new ContextThemeWrapper(MainActivity.this, R.style.LongClickDialog));
                    builder.setMessage("Would you like to alter your to-do list?")
                            .setPositiveButton("Remove", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    databaseHelper.removeTask(row);
                                    tableLayout.invalidate();
                                    populateTable(DatabaseHelper.SELECT_ALL_QUERY);
                                    orderTable();
                                    databaseHelper.printTableContents(Database.TasksTable.TABLE_NAME);
                                }
                            })
                            .setNegativeButton("Modify", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    final EditTaskDialog editTaskDialog = new EditTaskDialog();

                                    setData(row, DatabaseHelper.COL_DUE_DATE);
                                    editTaskDialog.setDate(getData());

                                    setData(row, DatabaseHelper.COL_CATEGORY);
                                    editTaskDialog.setCategory(getData());

                                    setData(row, DatabaseHelper.COL_DESCRIPTION);
                                    editTaskDialog.setDescription(getData());

                                    setData(row, DatabaseHelper.COL_RAW_DATE);
                                    editTaskDialog.setRawDate(getData());

                                    setData(row, DatabaseHelper.COL_PRIORITY);
                                    editTaskDialog.setPriority(getData());

                                    editTaskDialog.show(MainActivity.this.getFragmentManager(), "setEditDialogListener");
                                    editTaskDialog.setEditDialogListener(new EditTaskDialog.setEditTaskListener() {
                                        @Override
                                        public void onDoneClick(DialogFragment dialogFragment) {

                                            if (editTaskDialog.getDateField().matches("") &&
                                                    editTaskDialog.getDescription().matches("") &&
                                                    editTaskDialog.getCategory().matches("")) {
                                                Toast.makeText(MainActivity.this, "Please complete all fields",
                                                        Toast.LENGTH_SHORT).show();
                                            } else {
                                                if (editTaskDialog.getDateField().matches("")) {
                                                    Toast.makeText(MainActivity.this, "Please add a date",
                                                            Toast.LENGTH_SHORT).show();
                                                }
                                                if (editTaskDialog.getCategory().matches("")) {
                                                    Toast.makeText(MainActivity.this, "Please add a category",
                                                            Toast.LENGTH_SHORT).show();
                                                }
                                                if (editTaskDialog.getDescription().matches("")) {
                                                    Toast.makeText(MainActivity.this, "Please add a description",
                                                            Toast.LENGTH_SHORT).show();
                                                }
                                                if (!editTaskDialog.getDateField().matches("")
                                                        && !editTaskDialog.getCategory().matches("")
                                                        && !editTaskDialog.getDescription().matches("")) {

                                                    databaseHelper.editTask(
                                                            row,
                                                            editTaskDialog.getCategoryField(),
                                                            editTaskDialog.getDescriptionField(),
                                                            editTaskDialog.getDateField(),
                                                            editTaskDialog.getRawDate(),
                                                            checkBox.isChecked(),
                                                            editTaskDialog.getPriority());
                                                    databaseHelper.printTableContents(Database.TasksTable.TABLE_NAME);
                                                    tableLayout.invalidate();
                                                    populateTable(DatabaseHelper.SELECT_ALL_QUERY);
                                                    Toast.makeText(MainActivity.this, "Task modified successfully!",
                                                            Toast.LENGTH_SHORT).show();
                                                }
                                            }
                                        }
                                    });
                                }
                            });
                    builder.create().show();
                    return true;
                }
            });

            //add views
            tableRow.addView(dateField);
            tableRow.addView(categoryField);
            tableRow.addView(descField);
            tableRow.addView(priField);
            tableRow.addView(checkBox);

            tableLayout.addView(tableRow);

            cursor.moveToNext();
        }

        readDb.close();
        cursor.close();
    }

    /**
     * given the data set in the row/col mix, the value is given in string format
     * @return the value for the field as a string
     */
    public String getData(){return data;}

    /**
     * retrieves the appropriate data for the edit record dialog box
     * in order to populate the given fields with the appropriate values
     * as a generic function
     * @param row the given row to be accessed with respect to ID
     *            which is always the row number + 1
     * @param col the given column to be accessed where the column
     *            corresponds to the queries in the database helper class
     */
    public void setData(int row, int col){
        SQLiteDatabase readDb = databaseHelper.getReadableDatabase();
        Cursor cursor = readDb.rawQuery(DatabaseHelper.SELECT_ALL_QUERY, null);
        cursor.moveToFirst();
        cursor.move(row - 1);
        this.data = cursor.getString(col);
        readDb.close();
        cursor.close();
    }

    /**
     * strikes through the appropriate field by adding or removing bitwise operator flags
     * @param dateField the date field in the given row to be struck through or unstruck
     * @param categoryField the category field in the given row to be struck/unstruck
     * @param descField the desc field in the given row to be struck/unstruck
     * @param completed toggles whether or not the row is to be struck through or not
     */
    public void strikeThrough(TextView dateField, TextView categoryField,
                              TextView descField, TextView priField, boolean completed){
        if(completed) {
            dateField.setPaintFlags(dateField.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);
            categoryField.setPaintFlags(dateField.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);
            descField.setPaintFlags(dateField.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);
            //priField.setTextColor(getResources().getColor(R.color.red));

        } else {
            dateField.setPaintFlags(dateField.getPaintFlags() & (~ Paint.STRIKE_THRU_TEXT_FLAG));
            categoryField.setPaintFlags(dateField.getPaintFlags() & (~ Paint.STRIKE_THRU_TEXT_FLAG));
            descField.setPaintFlags(dateField.getPaintFlags() & (~ Paint.STRIKE_THRU_TEXT_FLAG));
        }
    }
}
