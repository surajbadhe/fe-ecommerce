<template>
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-6 col-md-8">
        <!-- Card wrapper -->
        <div class="card shadow-sm border-0 rounded-3">
          <div class="card-header bg-primary text-white text-center">
            <h4 class="mb-0">Add New Category</h4>
          </div>

          <div class="card-body p-4">
            <form @submit.prevent="addCategory">
              <!-- Category Name -->
              <div class="mb-3">
                <label class="form-label fw-bold">Category Name</label>
                <input
                    type="text"
                    class="form-control"
                    v-model="categoryName"
                    required
                    placeholder="Enter category name"
                >
              </div>

              <!-- Description -->
              <div class="mb-3">
                <label class="form-label fw-bold">Description</label>
                <textarea
                    class="form-control"
                    v-model="description"
                    rows="3"
                    required
                    placeholder="Enter description"
                ></textarea>
              </div>

              <!-- Image URL -->
              <div class="mb-3">
                <label class="form-label fw-bold">Image URL</label>
                <input
                    type="url"
                    class="form-control"
                    v-model="imageURL"
                    required
                    placeholder="https://example.com/image.jpg"
                >
              </div>
              <!-- Submit button -->
              <div class="d-grid">
                <button
                    type="submit"
                    class="btn btn-primary btn-lg"
                >
                  ✅ Submit
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      categoryName: "",
      description: "",
      imageURL: "",
      baseURL: "http://51.21.199.182/"
    };
  },
  methods: {
    async addCategory() {
      const newCategory = {
        categoryName: this.categoryName,
        description: this.description,
        imageUrl: this.imageURL

      };

      try {
        await axios.post(this.baseURL + "categories/", newCategory, {
          headers: {"Content-Type": "application/json"}
        });
        alert("✅ Category added successfully!");
        this.resetForm();
      } catch (err) {
        console.error("❌ Error adding category:", err);
        alert("Failed to add category. Check console for details.");
      }
    },
    resetForm() {
      this.categoryName = "";
      this.description = "";
      this.imageURL = "";
      //this.active = true;
    }
  }
};
</script>
